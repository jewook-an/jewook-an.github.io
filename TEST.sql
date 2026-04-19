
[제약 조건]
0. 테이블 관계
* TB_NBIPF01 (설계 마스터) 1 : N
* TB_NBIPF02 (설계별 담보/보험 명세) PLAN_ID로 연결

1. 이슈                          
    * 현재 가계약 DB(TB_NBIPF01, TB_NBIPF02)는 D+11 기준 미입금소멸건 등이 삭제되고 있음
    * 과거 이력 별도의 임시테이블을 통해 데이터 누적 관리 필요                          
    * 이에 따라 별도의 임시 테이블(가칭 TB_NBIPF01_TEMP, TB_NBIPF02_TEMP)을 생성하여 데이터 누적 관리 필요                        

2. 작업진행 방향                          
    1) IFRS17검증DB : TB_NBIPF01, TB_NBIPF02 테이블 대응 임시테이블 별도 생성(해당 임시테이블은 추후 데이터를 지속적으로 누적하여 가계약 관리용 테이블로 활용 예정)

3. 운영계DB에서 개발,검증계DB의 임시테이블로 데이터 적재를 위한 INSERT문 작업을 요청.
    * INSERT 대상 테이블: TB_NBIPF01, TB_NBIPF02
    * 기준 데이터: INSERT 수행일 기준 전일자 신규 청약 데이터
    예) 4/15 INSERT 시, OFR_YMD(청약일자) = 20260414 인 청약 전건

[참고 쿼리문]
SELECT '20260329' CRT_DATE  -- 데이터생성일 전날 2026.03.30 기준 20260329, A.*
FROM TB_NBIPF01 A
WHERE OFR_YMD BETWEEN '20260327' AND '20260329'  -- 데이터생성일 전날 2026.03.30 기준 20260329, 휴일일 경우 포함
ORDER BY OFR_YMD;

SELECT '20260329' CRT_DATE  -- 데이터생성일 전날 2026.03.30 기준 20260329, A.*
FROM TB_NBIPF02 A
WHERE CONT_NO IN (SELECT CONT_NO
   FROM TBL_NBIPF01
   WHERE OFR_YMD BETWEEN '20260327' AND '20260329')  -- 데이터생성일 전날 2026.03.30 기준 20260329, 휴일일 경우 포함

-----------------------------------------------------------
/*
가계약 데이터의 이력 보존을 위한 데이터 적재용 `INSERT` 문.
**운영계(Source)에서 개발/검증계 임시 테이블(Target)로 데이터를 적재**하는 스크립트 작성.
 `CRT_DATE` 컬럼을 추가 후 적재 시점(전일자 기준)을 기록하도록 구성.
*/


• 영업일 계산 로직(휴일 처리)은 별도 달력 테이블 또는 사내 공통 함수 활용 구현 필요.
• TB_NBIPF01_TEMP, TB_NBIPF02_TEMP 테이블명은 ABL Name 생성 규칙에 따른 수정 가능.

-- 1. 설계 마스터 임시 테이블 적재 (TB_NBIPF01_TEMP)
-- `OFR_YMD`(청약일자)가 배치 수행일 기준 전일(`SYSDATE - 1`)인 데이터 적재.

-- INSERT
INSERT INTO TB_NBIPF01_TEMP (CRT_DATE, /* 여기에 TB_NBIPF01의 모든 컬럼 나열 */)
SELECT 
    TO_CHAR(SYSDATE - 1, 'YYYYMMDD') AS CRT_DATE, 
    A.*
FROM TB_NBIPF01 A
WHERE A.OFR_YMD = TO_CHAR(SYSDATE - 1, 'YYYYMMDD');

-- 주말/휴일 적재가 누락되는 경우를 대비해 범위를 지정할 경우 (금~일 데이터를 월요일에 적재 시)
-- WHERE A.OFR_YMD BETWEEN '시작일자' AND '종료일자'

-- 2. 설계별 담보/보험 명세 임시 테이블 적재 (TB_NBIPF02_TEMP)
-- 마스터 테이블(`TB_NBIPF01`)과 `CONT_NO`(또는 `PLAN_ID`)로 조인 전일자 청약 건에 해당하는 상세 내역만 추출 후 적재.

-- INSERT
INSERT INTO TB_NBIPF02_TEMP (CRT_DATE, /* 여기에 TB_NBIPF02의 모든 컬럼 나열 */)
SELECT 
    TO_CHAR(SYSDATE - 1, 'YYYYMMDD') AS CRT_DATE, 
    A.*
FROM TB_NBIPF02 A
WHERE EXISTS (
    SELECT 1 
    FROM TB_NBIPF01 B
    WHERE B.CONT_NO = A.CONT_NO     -- 참고 쿼리의 연결 키 기준
      AND B.OFR_YMD = TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
);

--------------------------------------------------------------------------------------------

### 💡 작업 시 고려사항 (Technical Tips)
 - 컬럼 매핑 : `INSERT INTO ... SELECT *` 방식은 임시 테이블, 원본 테이블 컬럼순서, 개수일치 필요.
    임시 테이블에 `CRT_DATE`가 추가시, `CRT_DATE` 명시, 뒤에 `A.*`를 붙여 순서를 맞춰야 합니다.
 - 연결 키(Join Key) : `PLAN_ID`, 참고 쿼리 > `CONT_NO` 사용.
    실 DB Schema상 두 테이블 Connection "Primary Key / Foreign Key" 관계에 있는 컬럼(대개 가계약 단계에서는 설계번호 등)을 사용 필요.
 - 성능 최적화 : 적재 대상 데이터 많을시, `OFR_YMD` 컬럼 인덱스 필요여부 확인.
    또한, 대량 적재 시에는 Oracle의 `/*+ APPEND */` 힌트 사용을 검토 가능, 임시 테이블 로깅 설정에 따라 유의해서 사용.
 - 휴일 처리 : 참고 쿼리에 언급된 것처럼 월요일 배치의 경우 `BETWEEN` 사용 금, 토, 일 데이터를 한 번에 적재하는 로직이 필요할 수 있습니다. 위 쿼리는 "일 단위 배치" 기준 작성.

--------------------------------------------------------------------------------------------


• 영업일 계산 로직(휴일 처리)은 별도 달력 테이블 또는 사내 공통 함수 활용 구현 필요.
• TB_NBIPF01_TEMP, TB_NBIPF02_TEMP 테이블명은 ABL Name 생성 규칙에 따른 수정 가능.

-- TB_NBIPF01_TEMP INSERT
-- 수행일: 예) 2026-04-16  →  CRT_DATE = '20260415', OFR_YMD = '20260415'
-- :p_start_ymd  : 수행일 기준 전일 or 지정일자(휴일 및 ABL 조건에 따라 조정)
INSERT INTO TB_NBIPF01_TEMP
SELECT
    TO_CHAR(SYSDATE - 1, 'YYYYMMDD') AS CRT_DATE,   --필요없을때 제거
    A.*
FROM TB_NBIPF01 A
WHERE OFR_YMD BETWEEN :p_start_ymd   -- 휴일 포함 시 조정
    AND TO_CHAR(SYSDATE - 1, 'YYYYMMDD');

COMMIT;

-- TB_NBIPF02_TEMP INSERT
-- 수행일: 예) 2026-04-16  →  CRT_DATE = '20260415'
INSERT INTO TB_NBIPF02_TEMP
SELECT TO_CHAR(SYSDATE - 1, 'YYYYMMDD') AS CRT_DATE,   --필요없을때 제거
       A.*
FROM   TB_NBIPF02 A
WHERE  CONT_NO IN (
           SELECT CONT_NO
           FROM   TB_NBIPF01
           WHERE  OFR_YMD BETWEEN :p_start_ymd   -- 휴일 포함 시 조정
                              AND TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
       );

COMMIT;

---------------------------------------------------------------------------------
Database Name : NGS DB (Hos 명 : STG_NGSP)

Temp Table Name 생성
tmp_NBIPF01_61612057_260731 (tmp_NBIPF01_61612057_260531)
tmp_NBIPF02_61612057_260731 (tmp_NBIPF02_61612057_260531)

-- TB_PDMGF01([유지]일자관리기본) 활용
SELECT MAX(SLRC_YM_YMD)
FROM TB_PDMGF01
WHERE HOLY_CD = '00'
    AND SLRC_YM_YMD <= TO_CHAR(SYSDATE - 1, 'YYYYMMDD');

-- TB_NBIPF01_TEMP INSERT
INSERT INTO tmp_NBIPF01_61612057_260731
SELECT A.*
FROM TB_NBIPF01 A
WHERE OFR_YMD BETWEEN (
        SELECT MAX(SLRC_YM_YMD)
        FROM TB_PDMGF01
        WHERE HOLY_CD = '00'
            AND SLRC_YM_YMD <= TO_CHAR(SYSDATE - 1, 'YYYYMMDD'))
    AND TO_CHAR(SYSDATE - 1, 'YYYYMMDD');

COMMIT;

-- TB_NBIPF02_TEMP INSERT
INSERT INTO tmp_NBIPF02_61612057_260731
SELECT A.*
FROM   TB_NBIPF02 A
WHERE  CONT_NO IN (
           SELECT CONT_NO
           FROM   TB_NBIPF01
           WHERE  OFR_YMD BETWEEN (
                    SELECT MAX(SLRC_YM_YMD)
                    FROM TB_PDMGF01
                    WHERE HOLY_CD = '00'
                        AND SLRC_YM_YMD <= TO_CHAR(SYSDATE - 1, 'YYYYMMDD'))
                AND TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
       );

COMMIT;


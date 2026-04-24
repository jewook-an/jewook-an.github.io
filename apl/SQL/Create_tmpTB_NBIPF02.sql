-- ============================================================
-- TABLE : tmp_NBIPF02_61612057_260731
-- SOURCE: TB_NBIPF02 (가계약보험/담보명세)
-- DB    : IFRS DB (STG_IFRS17T)
-- ============================================================
CREATE TABLE "IFRS_DEV".tmp_NBIPF02_61612057_260731
(
    PLAN_INSR_ID                    VARCHAR2(20)      NOT NULL,   -- 설계보험ID
    PLAN_ID                         VARCHAR2(20)      NULL,       -- 설계ID
    CONT_NO                         VARCHAR2(13)      NULL,       -- 계약번호
    INSR_ID                         VARCHAR2(20)      NULL,       -- 보험ID
    INSCD                           VARCHAR2(6)       NOT NULL,   -- 보험코드
    INSR_VCD                        VARCHAR2(3)       NOT NULL,   -- 보험버전코드
    INSCD_SC_CD                     VARCHAR2(2)       NOT NULL,   -- 보험코드구분코드
    INSR_LINE_CD                    VARCHAR2(2)       NOT NULL,   -- 보험종목코드
    INSR_STAT_CD                    VARCHAR2(2)       NOT NULL,   -- 보험상태코드
    INSR_DTL_STAT_CD                VARCHAR2(6)       NOT NULL,   -- 보험상세상태코드
    PAD_STAT_CD                     VARCHAR2(2)       NOT NULL,   -- 납입상태코드
    CONT_AMT                        NUMBER(15)        NOT NULL,   -- 계약금액
    PRM                             NUMBER(15)        NOT NULL,   -- 보험료
    MPAD_CNVL_PRM                   NUMBER(15)        NOT NULL,   -- 월납환산보험료
    NET_PRM                         NUMBER(15)        NOT NULL,   -- 순보험료
    EXTRA_PRM                       NUMBER(15)        NOT NULL,   -- 할증보험료
    PAD_EXMP_PRM                    NUMBER(15)        NOT NULL,   -- 납입면제보험료
    CONT_YMD                        VARCHAR2(8)       NULL,       -- 계약일자
    EXTC_YMD                        VARCHAR2(8)       NULL,       -- 소멸일자
    RSPN_BGN_YMD                    VARCHAR2(8)       NULL,       -- 책임개시일자
    EXP_YMD                         VARCHAR2(8)       NULL,       -- 만기일자
    TH2_INSR_PRD_BGN_YR             VARCHAR2(4)       NULL,       -- 제2보험기간개시년도
    INSR_PRD_TYP_CD                 VARCHAR2(2)       NOT NULL,   -- 보험기간유형코드
    INSR_PRD_TYP_VAL                NUMBER(3)         NOT NULL,   -- 보험기간유형값
    INSR_PRD                        NUMBER(3)         NOT NULL,   -- 보험기간
    PAD_PRD_TYP_CD                  VARCHAR2(2)       NOT NULL,   -- 납입기간유형코드
    PAD_PRD_TYP_VAL                 NUMBER(3)         NOT NULL,   -- 납입기간유형값
    PAD_CYL_CD                      VARCHAR2(2)       NOT NULL,   -- 납입주기코드
    PAD_MMS                         NUMBER(5)         NOT NULL,   -- 납입개월수
    UKEP_YM                         VARCHAR2(6)       NULL,       -- 유지년월
    UKEP_YMD                        VARCHAR2(8)       NULL,       -- 유지일자
    UKEP_NTS                        NUMBER(5)         NOT NULL,   -- 유지횟수
    APLC_PRAT_CD                    VARCHAR2(2)       NOT NULL,   -- 적용요율코드
    AVR_INSR_PRAT                   NUMBER(7,3)       NOT NULL,   -- 평균보험요율
    PRE_TRT_RMDR_NTS                NUMBER(5)         NOT NULL,   -- 선처리잔여횟수
    CONT_CSTU_TYP_CD                VARCHAR2(2)       NOT NULL,   -- 계약구성유형코드
    MIDAD_YN                        VARCHAR2(1)       NULL,       -- 중도부가여부
    PRSV_FLCT_YN                    VARCHAR2(1)       NULL,       -- 준비금변동여부
    ALWC_TYP_CD                     VARCHAR2(2)       NOT NULL,   -- 수당유형코드
    ALWC_CD                         VARCHAR2(5)       NOT NULL,   -- 수당코드
    RENW_TMS                        NUMBER(3)         NOT NULL,   -- 갱신회차
    RENW_TRTY_YN                    VARCHAR2(1)       NULL,       -- 갱신특약여부
    CLCT_CNSLT_NO                   VARCHAR2(10)      NULL,       -- 모집컨설턴트번호
    CRNCY_CD                        VARCHAR2(3)       NOT NULL,   -- 화폐코드
    LOG_CHKDG                       NUMBER(7)         NOT NULL,   -- 로그체크디지트
    TH1_ANUT_INSR_PRD_TYP_VAL       NUMBER(3)         NOT NULL,   -- 제1연금보험기간유형값
    TH1_ANUT_BGN_YR                 VARCHAR2(4)       NULL,       -- 제1연금개시년도
    TH1_ANUT_APL_RTO                NUMBER(3)         NOT NULL,   -- 제1연금신청비율
    TRTR_ENO                        VARCHAR2(10)      NULL,       -- 처리자사번
    TRT_DTM                         TIMESTAMP         NOT NULL    -- 처리일시
);

-- PK 제약조건
ALTER TABLE tmp_NBIPF02_61612057_260731
    ADD CONSTRAINT PK_tmp_NBIPF02_61612057_260731
    PRIMARY KEY (PLAN_INSR_ID);

-- 조회 성능용 인덱스(TB_NBIPF01 JOIN 용)
CREATE INDEX IDX_tmp_NBIPF02_61612057_PLAN
    ON tmp_NBIPF02_61612057_260731 (PLAN_ID); 
-- INSERT 서브쿼리 IN 조건 용
CREATE INDEX IDX_tmp_NBIPF02_61612057_CONT
    ON tmp_NBIPF02_61612057_260731 (CONT_NO);
    
-- FK 제약조건 (PLAN_ID → tmp_NBIPF01_61612057_260731)
ALTER TABLE tmp_NBIPF02_61612057_260731
    ADD CONSTRAINT FK_tmp_NBIPF02_61612057_PLAN_ID
    FOREIGN KEY (PLAN_ID)
    REFERENCES tmp_NBIPF01_61612057_260731 (PLAN_ID);

-- 테이블 주석
COMMENT ON TABLE tmp_NBIPF02_61612057_260731
    IS '가계약보험명세 임시테이블 (TB_NBIPF02 기반, 누적 보관용)';
-- ============================================================
-- TABLE : tmp_NBIPF01_61612057_260731
-- SOURCE: TB_NBIPF01 (가계약기본)
-- DB    : IFRS DB (STG_IFRS17T)
-- ============================================================
CREATE TABLE "IFRS_DEV".tmp_NBIPF01_61612057_260731
(
    PLAN_ID                     VARCHAR2(20)      NOT NULL,   -- 설계ID
    CONT_NO                     VARCHAR2(13)      NULL,       -- 계약번호
    PLAN_SC_CD                  VARCHAR2(2)       NOT NULL,   -- 설계구분코드
    CONT_SC_CD                  VARCHAR2(2)       NOT NULL,   -- 계약구분코드
    CONT_STAT_CD                VARCHAR2(2)       NOT NULL,   -- 계약상태코드
    CONT_DTL_STAT_CD            VARCHAR2(6)       NOT NULL,   -- 계약상세상태코드
    PRCD                        VARCHAR2(6)       NOT NULL,   -- 상품코드
    PRDT_VCD                    VARCHAR2(3)       NOT NULL,   -- 상품버전코드
    GRINS_PRDT_TYP_CD           VARCHAR2(2)       NOT NULL,   -- 단체보험상품유형코드
    CLCT_CNSLT_NO               VARCHAR2(10)      NULL,       -- 모집컨설턴트번호
    OFR_YMD                     VARCHAR2(8)       NULL,       -- 청약일자
    CONT_YMD                    VARCHAR2(8)       NULL,       -- 계약일자
    CONT_EXTC_YMD               VARCHAR2(8)       NULL,       -- 계약소멸일자
    EXP_YMD                     VARCHAR2(8)       NULL,       -- 만기일자
    CONT_PRD                    NUMBER(3)         NOT NULL,   -- 계약기간
    CONT_PRD_TYP_CD             VARCHAR2(2)       NOT NULL,   -- 계약기간유형코드
    LST_RCTM_YM                 VARCHAR2(6)       NULL,       -- 최종입금년월
    LST_RCTM_YMD                VARCHAR2(8)       NULL,       -- 최종입금일자
    CUML_RCTM_NTS               NUMBER(5)         NOT NULL,   -- 누적입금횟수
    UKEP_YM                     VARCHAR2(6)       NULL,       -- 유지년월
    UKEP_YMD                    VARCHAR2(8)       NULL,       -- 유지일자
    UKEP_NTS                    NUMBER(5)         NOT NULL,   -- 유지횟수
    PAD_STAT_CD                 VARCHAR2(2)       NOT NULL,   -- 납입상태코드
    PAD_MTH_CD                  VARCHAR2(2)       NOT NULL,   -- 납입방법코드
    PAD_CYL_CD                  VARCHAR2(2)       NOT NULL,   -- 납입주기코드
    G_HNDL_CD                   VARCHAR2(2)       NOT NULL,   -- 단체취급코드
    PG_CLCT_SC_CD               VARCHAR2(1)       NOT NULL,   -- 개인단체모집구분코드
    CONT_CLCT_TYP_CD            VARCHAR2(2)       NOT NULL,   -- 계약모집유형코드
    CONT_PRTY_CD                VARCHAR2(2)       NOT NULL,   -- 계약적부코드
    RLNM_CNF_CD                 VARCHAR2(1)       NOT NULL,   -- 실명확인코드
    CRNCY_CD                    VARCHAR2(3)       NOT NULL,   -- 화폐코드
    BEFR_APRV_YN                VARCHAR2(1)       NULL,       -- 사전승인여부
    SECUS_PBL_TYP_CD            VARCHAR2(2)       NOT NULL,   -- 증권발행유형코드
    ANUT_TAXSY_SPT_CD           VARCHAR2(2)       NOT NULL,   -- 연금세제지원코드
    RLPAD_PRM                   NUMBER(15)        NOT NULL,   -- 실납입보험료
    SMTOT_PRM                   NUMBER(15)        NOT NULL,   -- 합계보험료
    PAD_MMS                     NUMBER(5)         NOT NULL,   -- 납입개월수
    PAD_STOP_MMS                NUMBER(5)         NOT NULL,   -- 납입중지개월수
    UNDTK_SC_CD                 VARCHAR2(2)       NOT NULL,   -- 인수구분코드
    RNST_YN                     VARCHAR2(1)       NULL,       -- 부활여부
    RENW_YN                     VARCHAR2(1)       NULL,       -- 갱신여부
    INFO_PRTC_REQ_TYP_CD        VARCHAR2(1)       NOT NULL,   -- 정보보호요청유형코드
    CLCT_CNSLT_DFRNC_YN         VARCHAR2(1)       NULL,       -- 모집컨설턴트상이여부
    ANUT_APL_CD                 VARCHAR2(2)       NOT NULL,   -- 연금신청코드
    RATE_INLCK_APLC_IRT_CD      VARCHAR2(1)       NOT NULL,   -- 금리연동적용이율코드
    AMT_SUVL_CONT_CD            VARCHAR2(1)       NOT NULL,   -- 금액잔존계약코드
    RPLC_STIP_SC_CD             VARCHAR2(2)       NOT NULL,   -- 대체약정구분코드
    DTH_PRPYM_TYP_CD            VARCHAR2(2)       NOT NULL,   -- 사망선지급유형코드
    APM_NTS                     NUMBER(5)         NOT NULL,   -- 월차횟수
    APLN_PAD_SC_CD              VARCHAR2(2)       NOT NULL,   -- 자동대출납입구분코드
    PLLN_YN                     VARCHAR2(1)       NULL,       -- 보험계약대출여부
    PYM_TRT_RSVT_CD             VARCHAR2(2)       NOT NULL,   -- 지급처리보류코드
    BND_ATTM_CONT_CD            VARCHAR2(1)       NOT NULL,   -- 채권압류계약코드
    UTRDM_ACPN_YN               VARCHAR2(1)       NULL,       -- 통합입출금접수여부
    ONPST_CO_ENO                VARCHAR2(10)      NULL,       -- 소속회사사번
    PRPAD_NTS                   NUMBER(3)         NOT NULL,   -- 선납횟수
    CLCT_DOF_ORG_NO             VARCHAR2(6)       NULL,       -- 모집지역단조직번호
    CLCT_FOF_ORG_NO             VARCHAR2(6)       NULL,       -- 모집지점조직번호
    CONT_CHG_YN                 VARCHAR2(1)       NULL,       -- 계약변경여부
    CNDTL_CONT_YN               VARCHAR2(1)       NULL,       -- 조건부계약여부
    CONT_CNVR_STAT_CD           VARCHAR2(1)       NOT NULL,   -- 계약전환상태코드
    CONT_CNVR_SC_CD             VARCHAR2(1)       NOT NULL,   -- 계약전환구분코드
    SPC_CONT_TYP_CD             VARCHAR2(2)       NOT NULL,   -- 특별계약유형코드
    PRTN_PYM_SC_CD              VARCHAR2(1)       NOT NULL,   -- 분할지급구분코드
    CONT_CHNL_SC_CD             VARCHAR2(2)       NOT NULL,   -- 계약채널구분코드
    CONT_CLMNY_G_TYP_CD         VARCHAR2(1)       NOT NULL,   -- 계약수금단체유형코드
    FRST_YR_CNVL_PRFM_AMT       NUMBER(15)        NOT NULL,   -- 1차년도환산성적금액
    MIDAD_YN                    VARCHAR2(1)       NULL,       -- 중도부가여부
    CONT_HNDL_TYP_CD            VARCHAR2(2)       NOT NULL,   -- 계약취급유형코드
    WUNIT_NO                    VARCHAR2(14)      NULL,       -- 사업소번호
    OCP_NO                      VARCHAR2(14)      NULL,       -- 직역번호
    INSR_UNIT_TRT_TYP_CD        VARCHAR2(2)       NOT NULL,   -- 보험단위처리유형코드
    LOG_CHKDG                   NUMBER(7)         NOT NULL,   -- 로그체크디지트
    CHNL_SC_CD                  VARCHAR2(2)       NOT NULL,   -- 채널구분코드
    LWST_DTH_GUA_STAT_CD        VARCHAR2(1)       NOT NULL,   -- 최저사망보증상태코드
    OFRFM_PBL_YN                VARCHAR2(1)       NULL,       -- 청약서발행여부
    OFRFM_PBL_DTM               TIMESTAMP         NULL,       -- 청약서발행일시
    RCTM_CMPLT_YN               VARCHAR2(1)       NULL,       -- 입금완료여부
    OFRFM_PRNT_NTS              NUMBER(3)         NOT NULL,   -- 청약서인쇄횟수
    TRTR_ENO                    VARCHAR2(10)      NOT NULL,   -- 처리자사번
    TRT_DTM                     TIMESTAMP         NOT NULL    -- 처리일시
);

-- PK 제약조건
ALTER TABLE tmp_NBIPF01_61612057_260731
    ADD CONSTRAINT PK_tmp_NBIPF01_61612057_260731
    PRIMARY KEY (PLAN_ID);

-- 조회 성능용 인덱스 (OFR_YMD 기준 배치 적재/조회)
CREATE INDEX IDX_tmp_NBIPF01_61612057_OFR
    ON tmp_NBIPF01_61612057_260731 (OFR_YMD);

-- 테이블 주석
COMMENT ON TABLE tmp_NBIPF01_61612057_260731
    IS '가계약기본 임시테이블 (TB_NBIPF01 기반, 누적 보관용)';
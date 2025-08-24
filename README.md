# 📚 도서 관리 웹 서비스

이 프로젝트는 Spring Boot를 사용하여 개발한 간단한 도서 관리 웹 서비스입니다. <br>
사용자 관리, 도서 관리, 대출 및 반납 기능을 제공하며, GCP와 Terraform을 통해 CI/CD 및 인프라 자동화 배포를 구현했습니다.

<br>
<img width="1491" height="359" alt="Image" src="https://github.com/user-attachments/assets/b2540e36-5d9f-4f46-905e-1a3002334d68" />

## ✨ 기능
- 도서 관리: 도서 CRUD 연산
- 사용자 관리: 사용자 CRUD 연산
- 대출 관리: 대출 및 반납

## 🛠️ 기술 스택
### 백엔드 & 데이터베이스
- Language: `Java`
- Framework: `Spring Boot`, `Spring Data JPA`
- Database: `H2 (In-memory)`

### 인프라 & 배포
- Cloud: `GCP` (`Cloud Run`, `Artifact Registry`)
- IaC: `Terraform`
- CI/CD: `GitHub Actions`
- Containerization: `Docker`

## 🚀 CI/CD 파이프라인

1. Code Push
2. CI: Github Actions가 코드 변경 감지하고, 자동 빌드 수행
3. Containerize: 빌드된 이미지를 Docker 이미지 패키징
4. Push: 생성된 도커 이미지를 GCP Artifact Registry에 푸시
5. CD: Github Actions가 최신 컨테이너 이미지를 GCP CloudRun에 배포

## 🌿 브랜치 전략
- `dev`: 메인 개발 브랜치. 기능 구현 중심
- `deploy/inmemory`: H2 인메모리 데이터베이스를 사용하는 경량 배포 테스트 브랜치
- `deploy/terraform`: Terraform을 이용한 GCP 인프라 관리 및 배포(IaC) 테스트 브랜치
- `deploy/test`: GCP Cloud SQL 연동 기능 테스트 브랜치

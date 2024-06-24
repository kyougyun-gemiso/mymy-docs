## SQL 백업

### SQL 백업 개요

MYMY 아카이브의 데이터를 보호하고 복구할 수 있도록 정기적인 SQL 백업을 수행하는 것은 매우 중요합니다. 이 가이드는 데이터베이스를 백업하는 절차를 설명합니다.

### MySQL 데이터베이스 백업

#### 1. 백업 디렉토리 생성
백업 파일을 저장할 디렉토리를 생성합니다.
```bash
mkdir -p /path/to/backup
```

#### 2. mysqldump 명령어 실행
`mysqldump` 명령어를 사용하여 데이터베이스를 백업합니다. 다음 명령어를 실행하여 데이터베이스 백업을 수행합니다.
```bash
mysqldump -u [username] -p [database_name] > /path/to/backup/[backup_file].sql
```
- 예시:
```bash
mysqldump -u myuser -p mydatabase > /path/to/backup/mydatabase_backup.sql
```

#### 3. 암호화된 백업 (선택사항)
데이터의 보안을 위해 백업 파일을 암호화할 수 있습니다. 다음 명령어를 사용하여 GPG로 백업 파일을 암호화합니다.
```bash
gpg -c /path/to/backup/[backup_file].sql
```
- 예시:
```bash
gpg -c /path/to/backup/mydatabase_backup.sql
```

#### 4. 백업 스크립트 자동화 (선택사항)
백업 작업을 자동화하기 위해 스크립트를 작성할 수 있습니다. 예시:
```bash
#!/bin/bash
DATE=$(date +%Y%m%d%H%M)
BACKUP_DIR="/path/to/backup"
DB_NAME="mydatabase"
DB_USER="myuser"
DB_PASS="mypassword"

mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/${DB_NAME}_backup_$DATE.sql

# 선택사항: 백업 파일을 암호화합니다.
gpg -c $BACKUP_DIR/${DB_NAME}_backup_$DATE.sql
```

#### 5. 크론 작업으로 백업 자동화
정기적으로 백업을 수행하기 위해 크론 작업을 설정할 수 있습니다. 크론 작업을 설정하려면 다음 명령어를 실행하여 크론 편집기를 엽니다.
```bash
crontab -e
```
다음 줄을 추가하여 매일 자정에 백업 스크립트를 실행합니다.
```bash
0 0 * * * /path/to/backup_script.sh
```

### 주의 사항

- **정기적인 백업 검증**: 백업 파일이 정상적으로 생성되었는지 정기적으로 확인하십시오.
- **백업 파일 보관**: 백업 파일을 안전한 장소에 보관하고, 물리적으로 분리된 장소에 복사본을 보관하는 것이 좋습니다.
- **복구 테스트**: 백업에서 데이터를 복구하는 절차를 정기적으로 테스트하여 실제 상황에서 복구가 원활하게 이루어질 수 있도록 합니다.

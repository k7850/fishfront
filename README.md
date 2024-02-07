
# 어항 관리 앱 프로젝트

## 개발 기간 및 인원

2023년 12월

김지원 개인프로젝트

Flutter 프론트엔드 - https://github.com/k7850/fishfront

Spring 백엔드 - https://github.com/k7850/fishback



## 주요 기능

어항 기록, 사진, 소속 생물 관리

생물별 상세 정보 저장, 백과사전 정보 연동

달력 일정 관리 체크리스트<br/>
기간 반복, 특정 요일 반복 설정.<br/>
중요도별 분류 기능

사진이나 동영상을 첨부한 게시글 작성과 댓글<br/>
내 어항과 연동해서 정보 공유하기




## 시연 영상(유튜브 링크) 

[![a](http://img.youtube.com/vi/hD3RAo5boKQ/0.jpg)](https://www.youtube.com/watch?v=hD3RAo5boKQ?t=0s)

https://www.youtube.com/watch?v=hD3RAo5boKQ



## 기술 스택

### Backend

 <img src="https://img.shields.io/badge/Springboot-6DB33F?style=for-the-badge&logo=SpringBoot&logoColor=white">
 
### Frontend

<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white">

### 데이터베이스
<img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=MySQL&logoColor=white">


## DB 설계

![mma drawio](https://github.com/k7850/fishfront/assets/135561696/295d93ab-76d6-43ff-9f87-05cd8a267ea0)



## 후기

모든 작업을 혼자서 진행하다 보니 계획수립부터 시행착오가 여럿 생겼다.

달력 일정 관리 알림의 특정 요일이나 주기마다 반복하는 기능을 db에 저장할 방법이 애매했다.
단일 날짜, 요일별, 며칠 간격으로 분류해서 시작 일과 간격 일을 저장하고 프론트에서 조립해서 달력에 표시하게 했다.

어항 수정 시 장비 객체 list와 이미지를 두 번으로 나눠서 전송하기보다 이미지를 base64로 인코딩해서 한 번에 보내게 변경했다.

처음 설계할 때 고려하지 못했던 부분인데, 어항 연동을 해서 게시글을 작성한 이후에 어항 정보를 수정하면 당연하게도 게시글의 어항 정보에도 반영되었다.
글 작성 시 어항 정보도 저장되게 할까 하다가 지금 상태가 재밌어 보여 그대로 놔뒀다.

게시판 페이징 처리
단순히 적용시키는건 쉬웠지만, 테스트해 보니 도중에 새 글이 작성되거나 삭제되면 같은 글이 중복되어 보이는 문제가 있었다. 마지막 글 id와 불러온 첫 글 id를 비교해서 해결했다.

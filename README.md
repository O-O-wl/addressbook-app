# swift-addressbookapp
<br>

## STEP1

<img width="508" alt="스크린샷 2019-11-22 오전 4 56 36" src="https://user-images.githubusercontent.com/39197978/69372133-7ac48e00-0ce4-11ea-949a-256d1975ca8e.png">

### 진행 🏃‍♂️

Contacts 프레임워크에 대해 학습하며 진행했다.

기존 주소록에서 정보를 가져오는 스탭을 진행했다.

`CNContactStore` 라는 객체는 주소록 , 그룹 , 컨테이너를 주소록 데이터 베이스에서 fetch / save 를 담당하는 객체이다.

그부분을 이용해서 구현/적용했다.  기본적으로 Contacts는  readOnly 이기때문에 Thread-Safe 하다고 한다. 

과제를 진행하며 Contact에 관련된 Task들을 담는 별도의 Queue를 만들고 관련 Task 실행시마다 같은 Queue를 재사용했다. 

관련 키 `CNContactGivenNameKey … `  등의 Key를 담은 요청을 만들어서 `CNContactStore` 에 Fetch를 요청하면 key에 해당하는 프로퍼티들을 가진 NSContact 객체를 반환해주었다.

 이 데이터를 View에 맞는 모델로 변환후 프리젠팅하게 로직을 구현했다.
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

—

<br>

## STEP2

<img width="497" alt="스크린샷 2019-11-26 오후 3 47 04" src="https://user-images.githubusercontent.com/39197978/69641477-a0b2af80-10a3-11ea-84ae-b627740d86c1.png">



해당 스탭에서는 Table Section Header 와 IndexTitle을 구현했다.

섹션은 행들을 그룹화하고 그룹간의 경계를 보여주는 뷰이다.

내가 잘 모르고 잘 사용하지 않던 UITableViewDataSource 프로토콜의 메소드를 구현했다.

- *numberOfSectionsInTableView:* method – 모든 섹션의 갯수을 반환
- *titleForHeaderInSection:* method – 섹션들 각각의 헤더 타이틀들을 반환해주는 메소드이다. 섹션에 타이틀을 할당하지 않는다면 구현하지 않아도 되는 메소드이다.
- *numberOfRowsInSection:* method – 해당 섹션의 로우의 수를 반환해주는 메소드이다.
- cellForRowAtIndexPath: method – 이 메소드는  this method shouldn’t be new to you if you know how to display data in UITableView. It returns the table data for a particular section.
- *sectionIndexTitlesForTableView:* method – 테이블뷰 오른쪽에 리스트형태로 인덱스되어진 타이틀을 반환해준다.

- *sectionForSectionIndexTitle:* method – 특정인덱스가 탭되면 어디로 점프할지 선택된 섹션의 인덱스를 반환해준다. 





 
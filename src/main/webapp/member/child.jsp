<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
    <script>

    var child_value = "자식";

    function call_parent(){  //부모창에서 자식창에 값 전달
        try{

            opener.parent_value = "부모창 호출";
            opener.parent_function(); // 부모창 함수 호출

        }catch(e){ // 부모 자식간의 연결이 끊어졌을 경우 처리
            alert('팝업창을 다시 열어주세요');
        }
    }

    function child_function(){
        alert(child_value);
    }

    // opener 로 부모창에 접근하여 popup이라는 자식창 속성을 주입
    // (부모창에 popup 변수 선언 안해도 사용 가능) 
    opener.popup = this;
        
    </script>
    </head>
    <body>
        <input type='button' value='open' onclick='call_parent()' />
    </body>
</html>
drop USER madang cascade; -- madang이라는 계정이 혹시 있다면 삭제해라

create USER madang identified by madang; -- madang 계정 생성

grant connect, resource to madang; -- connect권한 주고, resource들 다룰 수 있는 권한 준다.
grant create view, create synonym to madang; -- 생성 기능 준다.

alter user madang account unlock;

--현재 계정의 접속해제하고 madang 계정으로 접속해본다.
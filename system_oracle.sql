drop USER madang cascade; -- madang�̶�� ������ Ȥ�� �ִٸ� �����ض�

create USER madang identified by madang; -- madang ���� ����

grant connect, resource to madang; -- connect���� �ְ�, resource�� �ٷ� �� �ִ� ���� �ش�.
grant create view, create synonym to madang; -- ���� ��� �ش�.

alter user madang account unlock;

--���� ������ ���������ϰ� madang �������� �����غ���.
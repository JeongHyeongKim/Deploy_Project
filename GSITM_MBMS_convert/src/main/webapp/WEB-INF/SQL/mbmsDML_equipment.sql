CREATE SEQUENCE room_equipment_seq START WITH 100;

-- 회의실번호, 비품번호, 비품명, 수량
INSERT INTO room_equipment VALUES (101, 101, '빔프로젝터', 1);
INSERT INTO room_equipment VALUES (101, 102, '마이크', 2);
INSERT INTO room_equipment VALUES (101, 103, '노트북', 1);
INSERT INTO room_equipment VALUES (101, 104, '화이트보드', 1);
INSERT INTO room_equipment VALUES (102, 105, '빔프로젝터', 1);
INSERT INTO room_equipment VALUES (102, 106, '마이크', 2);
INSERT INTO room_equipment VALUES (102, 107, '노트북', 1);


ALTER SEQUENCE room_equipment_SEQ INCREMENT BY 8;
select room_equipment_SEQ.nextval from dual;
alter sequence room_equipment_SEQ increment by 1;
select room_equipment_SEQ.currval from dual;
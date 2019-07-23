INSERT INTO Reserve_history VALUES(1000, 101, 'it1235', TO_DATE('2019-05-05 13:00', 'yyyy-MM-dd HH24:mi'), TO_DATE('2019-05-05 15:00', 'yyyy-MM-dd HH24:mi'),
    0, 'IT1010', null, 0, 'IT1010', null, 0, null, sysdate, 20000, '채용 면접', '면접', 5, 7, 'N');
INSERT INTO Reserve_history VALUES(1001, 101, 'it1235', TO_DATE('2019-05-07 09:00', 'yyyy-MM-dd HH24:mi'), TO_DATE('2019-05-08 18:00', 'yyyy-MM-dd HH24:mi'),
    0, 'IT1010', null, 0, 'IT1010', null, 0, null, sysdate, 20000, '채용 면접', '면접', 5, 7, 'N');
INSERT INTO Reserve_history VALUES(1002, 101, 'it1235', TO_DATE('2019-05-05 16:00', 'yyyy-MM-dd HH24:mi'), TO_DATE('2019-05-05 18:00', 'yyyy-MM-dd HH24:mi'),
    0, 'IT1010', null, 0, 'IT1010', null, 0, null, sysdate, 20000, '채용 면접', '면접', 5, 7, 'N');
    

ALTER SEQUENCE Reserve_history_seq INCREMENT BY 3;
select Reserve_history_seq.nextval from dual;
alter sequence Reserve_history_seq increment by 1;
select Reserve_history_seq.currval from dual;
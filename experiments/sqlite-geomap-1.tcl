# http://geomapx.blogspot.ru/2009/10/tclsqlite.html
#
# Решение проблемы с типизацией переменных при биндинге в Tclsqlite
# Ярлыки: SQLite, Tcl
# Выполняем скрипт с нижеприведенным кодом:
# $ cat /tmp/test
#
package require sqlite3
sqlite3 db :memory:

db eval {create table test(a int);insert into test values (1);}

proc test {label sql result} {
    global i j
    puts -nonewline $label\t
    set _result [db eval $sql]
    if { $_result eq $result} {
        puts OK
    } else {
        puts ERROR\t$result!=$_result
    }
}

set i 1


test 1.0 {select typeof($i)} integer ;# it doesn't work in orig sqlite
test 1.1 {select * from test where a=$i} 1
test 1.2 {select * from test where 1=$i} 1 ;# it doesn't work in orig sqlite
test 1.3 {select a from test where a IN (cast($i AS INT), 160)} 1
test 1.4 {select a from test where 1 IN (cast($i AS INT), 160)} 1

# $ tclsh8.5 /tmp/test
# 1.0     ERROR   integer!=text
# 1.1     OK
# 1.2     ERROR   1!=
# 1.3     OK
# 1.4     OK

# А теперь тот же самый код запускаем в tclsh8.5 шелле
#
# % % 1.0 OK
# % 1.1   OK
# % 1.2   OK
# % 1.3   OK
# % 1.4   OK
#
# Результат выполнения, как видим, отличается. Это не единственный баг,
# возникающий из-за некорректного биндинга тиклевых переменных, еще есть баг с
# проверкой типа вставляемых данных в констрэйнтах на таблицу, а также баг с
# некорректным типом результата выполнения тиклевой функции из sql-запроса и
# другие. Собственно, само решение простое - сделать "честную" типизацию,
# проверяя, может ли переменная иметь числовое представление, вместо того,
# чтобы ограничиваться проверкой, имеет ли переменная уже такое представление -
# в тикле это отнюдь не одно и то же.

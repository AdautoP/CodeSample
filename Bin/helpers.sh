function removeRxTest () {
    grep -v "RxTest" $1 > $1.temp; mv $1.temp $1
}
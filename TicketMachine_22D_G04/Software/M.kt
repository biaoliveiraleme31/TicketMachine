import isel.leic.utils.Time

fun initM() {
    HAL.init()
}

fun isMEnabled() = HAL.isBit(0b01000000) //isBit a função do hardware que verifica se um determinado pino está a passar corrente (1) ou não (0).


/*
fun main() {
    initM()

    println("M state: ${isMEnabled()}")

    Time.sleep(1000)
    println("Enable M in hardware")
    Time.sleep(5000)

    println("M state: ${isMEnabled()}")
}

*/
fun main() {
    initM()
    println("M state: ${isMEnabled()}")
    Time.sleep(5000)
    println("M state: ${isMEnabled()}")
}
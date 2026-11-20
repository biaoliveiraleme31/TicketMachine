object TD {
    private const val FN_MASK = 0x10   // I4

    fun init() {
        SerialEmitter.init()
    }

    fun activatePrintingTicket(roundTrip: Boolean, origin: Int, destination: Int) {
        val rt = if (roundTrip) 1 else 0
        val prt = 1

        val data =
            rt or
                    (destination shl 1) or
                    (origin shl 5) or
                    (prt shl 9)

        SerialEmitter.send(SerialEmitter.Peripheral.TICKET, data)
    }

    fun activatePrintingTicket2(roundTrip: Boolean, origin: Int, destination: Int) {
        val rt = if (roundTrip) 1 else 0
        val prt = 1

        val data =
            rt or
                    (destination shl 1) or
                    (origin shl 5) or
                    (0 shl 9)

        SerialEmitter.send(SerialEmitter.Peripheral.TICKET, data)
    }


}
fun main() {
    HAL.init()
    LCD.init()
    LCD.loadEuroSymbol(0)
    LCD.loadArrowUp(1)
    LCD.loadArrowDown(2)
    TD.init()

    LCD.clear()
    LCD.cursor(0, 0)
    LCD.write("Teste bilhete")
    LCD.cursor(1, 0)
    LCD.write("A preparar...")
    Thread.sleep(1500)

    // imprime um bilhete qualquer
    TD.activatePrintingTicket(
        roundTrip = false,
        origin = 0,
        destination = 1
    )

    LCD.clear()
    LCD.cursor(0, 0)
    LCD.write("Bilhete impresso")
    LCD.cursor(1, 0)
    LCD.write("Colete agora")

    // fica vivo sem fazer mais nada
    while (true) {
        Thread.sleep(500)
    }
}
const MAX_ENERGIA = 100;

function daño(atacante, atacado) {
    let dañoPotencial = Math.round((10*atacante.nivel*atacante.ataque)/(atacado.nivel*atacado.defensa));
    return Math.min(atacado.energía, dañoPotencial);
}

// Ejercicio 1

function Slime(ataque, defensa){
    this.energía = MAX_ENERGIA
    this.nivel = 1
    this.ataque = Math.max(1,ataque)
    this.defensa = Math.max(1,defensa)
}


// Ejercicio 2

Slime.prototype.actualizarEnergía = function(incremento){
    this.energía = Math.min(Math.max(this.energía + incremento,0),MAX_ENERGIA)
}

// Ejercicio 3

Slime.prototype.atacar = function(slimeDefensivo){
    if(0 < this.energía){
        let d = daño(this, slimeDefensivo) // Si se hace inline está mal porque el segundo calculo de daño es incorrecto si queda con menos energia que el daño recibido
        slimeDefensivo.actualizarEnergía(-d)
        this.actualizarEnergía(d)
    }
}


// Ejercicio 4

Slime.prototype.duelo = function(oponente){
    // this es el retador
    let energia0 = oponente.energía
    this.atacar(oponente)
    oponente.atacar(this)
    if(energia0 > oponente.energía){
        //this es el retador
        this.nivel = this.nivel + 1
        return this
    }else{
        oponente.nivel = oponente.nivel + 1
        return oponente
    }
}


// Ejercicio 5
function SlimeSanador(ataque, defensa, poder){
    Slime.call(this,ataque,defensa)
    this.poder = poder
}

Object.setPrototypeOf(SlimeSanador.prototype, Slime.prototype)

SlimeSanador.prototype.curar = function(paciente){
    paciente.actualizarEnergía(this.poder * this.nivel)
}

// Ejercicio 6

Slime.prototype.reproducirse = function(){
    let gasto_de_energia = Math.floor(100/this.nivel)
    if(gasto_de_energia < this.energía){
        this.actualizarEnergía(- gasto_de_energia)
        let hijito = Object.assign({}, this)
        hijito.nivel = 1
        hijito.energía = MAX_ENERGIA
        hijito.padre = this
        Object.setPrototypeOf(hijito, Object.getPrototypeOf(this))
        return hijito
    }
}

Slime.prototype.esDescendienteDe = function(otro){
    return this.padre === otro || (this.padre !== undefined && this.padre.esDescendienteDe(otro))
}



//Tests

function testEjemplo(res) {
  res.write("\n|| Probando la suma ||\n");
  let sumando1 = 4;
  let sumando2 = 6;
  let resultado_obtenido = sumando1 + sumando2;
  let resultado_esperado = 10;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = "4";
  sumando2 = "6";
  resultado_obtenido = sumando1 + sumando2;
  resultado_esperado = "10";
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = 4;
  sumando2 = undefined;
  resultado_obtenido = sumando1 + sumando2;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido);
}


// Test Ejercicio 1
function testEjercicio1(res) {
    let slimeOfensivo = new Slime(20, 10);
    let slimeDefensivo = new Slime(10, 20);
    let slimeBalanceado = new Slime(15, 15);
    let slimeDesinflado = new Slime(0, 0);
    let todosLosSlimes = new Array(slimeOfensivo, slimeDefensivo, slimeBalanceado, slimeDesinflado);
	res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.ataque == 20)} tiene ataque 20.`, slimeOfensivo.ataque == 20);
	res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.defensa == 10)} tiene defensa 10.`, slimeOfensivo.defensa == 10);
	res.write(`El slime defensivo ${si_o_no(slimeDefensivo.ataque == 10)} tiene ataque 10.`, slimeDefensivo.ataque == 10);
	res.write(`El slime defensivo ${si_o_no(slimeDefensivo.defensa == 20)} tiene defensa 20.`, slimeDefensivo.defensa == 20);
	res.write(`El slime balanceado ${si_o_no(slimeBalanceado.ataque == 15)} tiene ataque 15.`, slimeBalanceado.ataque == 15);
	res.write(`El slime balanceado ${si_o_no(slimeBalanceado.defensa == 15)} tiene defensa 15.`, slimeBalanceado.defensa == 15);
	res.write(`El slime balanceado ${si_o_no(slimeDesinflado.ataque == 1)} tiene ataque 1.`, slimeDesinflado.ataque == 1);
	res.write(`El slime balanceado ${si_o_no(slimeDesinflado.defensa == 1)} tiene defensa 1.`, slimeDesinflado.defensa == 1);
    let todosNivel1 = todosLosSlimes.reduce((res, x) => x.nivel == 1 && res, true);
    let todosEnergíaMáxima = todosLosSlimes.reduce((res, x) => x.energía == MAX_ENERGIA && res, true);
	res.write(`Se verifica que ${si_o_no(todosNivel1)} todos los slimes tienen nivel 1.`, todosNivel1);
	res.write(`Se verifica que ${si_o_no(todosEnergíaMáxima)} todos los slimes tienen la máxima energía posible.`, todosEnergíaMáxima);
}

// Test Ejercicio 2
function testEjercicio2(res) {
    let slimeBalanceado = new Slime(15, 15);
    res.write(`El slime balanceado ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} empieza con la máxima energía posible.`, slimeBalanceado.energía == MAX_ENERGIA);
    slimeBalanceado.actualizarEnergía(20);
    res.write(`Después de comer, ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} sigue teniendo la misma energía (ya era la máxima posible).`, slimeBalanceado.energía == MAX_ENERGIA);
    slimeBalanceado.actualizarEnergía(-25);
    res.write(`Después de cortarse con una piedra filosa, ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA-25)} perdió 25 puntos de energía.`, slimeBalanceado.energía == MAX_ENERGIA-25);
    slimeBalanceado.actualizarEnergía(-MAX_ENERGIA);
    res.write(`Después de caerse por un precipicio, ${si_o_no(slimeBalanceado.energía == 0)} se quedó sin energía.`, slimeBalanceado.energía == 0);
    slimeBalanceado.actualizarEnergía(MAX_ENERGIA+100);
    res.write(`Pero en el fondo del precipicio encontró mucha comida y ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} se recuperó.`, slimeBalanceado.energía == MAX_ENERGIA);
}

// Test Ejercicio 3
function testEjercicio3(res) {
    res.write("TESTS PROPIOS")
    // Nos fijamos que el slime1 robe bien la energia aunque el slime atacado termine con menos de esa energia. 
    let slime1 = new Slime(9000,1)
    slime1.energía = 90
    let slime2 = new Slime(10,1)
    slime2.energía = 10
    slime1.atacar(slime2)
    res.write(`La energía del slime es  ${si_o_no(slime1.energía == 100)} igual a 100.`, slime1.energía == 100)
    res.write("----------------------------------------------------")
    let slimeOfensivo = new Slime(20, 10);
    let slimeDefensivo = new Slime(10, 20);
    let slimeBalanceado = new Slime(15, 15);
    let slimeSinEnergía = new Slime(20, 20);
    slimeSinEnergía.energía = 0;
    slimeOfensivo.atacar(slimeDefensivo);
    res.write(`El slime ofensivo ataca al defensivo y su energía ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA)} se mantiene igual (ya era la máxima posible).`, slimeOfensivo.energía == MAX_ENERGIA);
    res.write(`El slime defensivo ${si_o_no(slimeDefensivo.energía == MAX_ENERGIA-10)} perdió 10 puntos de energía.`, slimeDefensivo.energía == MAX_ENERGIA-10);
    slimeBalanceado.atacar(slimeOfensivo);
    res.write(`El slime balanceado ataca al ofensivo y ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-15)} le quita 15 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-15);
    slimeDefensivo.atacar(slimeOfensivo);
    res.write(`El slime defensivo ataca al ofensivo y ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-25)} le quita otros 10 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-25);
    res.write(`El slime defensivo ${si_o_no(slimeDefensivo.energía == MAX_ENERGIA)} se recuperó por completo.`, slimeDefensivo.energía == MAX_ENERGIA);
    slimeOfensivo.atacar(slimeBalanceado);
    res.write(`El slime ofensivo ataca al balanceado y ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA-13)} le quita 13 puntos de energía.`, slimeBalanceado.energía == MAX_ENERGIA-13);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-12)} recuperó 13 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-12);
    slimeBalanceado.atacar(slimeOfensivo);
    res.write(`El slime balanceado ataca al ofensivo y ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-27)} le quita 15 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-27);
    res.write(`El slime balanceado ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} se recuperó por completo.`, slimeBalanceado.energía == MAX_ENERGIA);
    slimeSinEnergía.atacar(slimeBalanceado);
    res.write(`El slime sin energía intenta atacar al balanceado y su esfuerzo ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} es inútil.`, slimeBalanceado.energía == MAX_ENERGIA);

}

// Test Ejercicio 4
function testEjercicio4(res) {
    let slimeOfensivo = new Slime(20, 10);
    let slimeDefensivo = new Slime(10, 20);
    let slimeBalanceado = new Slime(15, 15);
    let slimeSinEnergía = new Slime(20, 20);
    slimeSinEnergía.energía = 0;
    
    let ganador1 = slimeOfensivo.duelo(slimeDefensivo);
    res.write(`El slime ofensivo reta a duelo al defensivo y ${si_o_no(ganador1 === slimeDefensivo)} gana el defensivo.`, ganador1 == slimeDefensivo);
    res.write(`El slime defensivo ahora ${si_o_no(slimeDefensivo.nivel == 2)} tiene nivel 2.`, slimeDefensivo.nivel == 2);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-10)} perdió 10 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-10);
    let ganador2 = slimeBalanceado.duelo(slimeDefensivo);
    res.write(`El slime balanceado reta a duelo al defensivo y ${si_o_no(ganador2 === slimeDefensivo)} gana el defensivo.`, ganador2 == slimeDefensivo);
    res.write(`El slime defensivo ahora ${si_o_no(slimeDefensivo.nivel == 3)} tiene nivel 3.`, slimeDefensivo.nivel == 3);
    res.write(`El slime balanceado ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA-13)} perdió 13 puntos de energía.`, slimeBalanceado.energía == MAX_ENERGIA-13);
    let ganador3 = slimeBalanceado.duelo(slimeOfensivo);
    res.write(`El slime balanceado reta a duelo al ofensivo y ${si_o_no(ganador3 === slimeBalanceado)} le gana.`, ganador3 == slimeBalanceado);
    res.write(`El slime balanceado ahora ${si_o_no(slimeBalanceado.nivel == 2)} tiene nivel 2.`, slimeBalanceado.nivel == 2);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-12)} perdió otros 2 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-12);
    res.write(`El slime balanceado ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA-13)} tiene la misma energía que antes del duelo.`, slimeBalanceado.energía == MAX_ENERGIA-13);
    let ganador4 = slimeOfensivo.duelo(slimeSinEnergía);
    res.write(`El slime ofensivo reta a duelo al slime sin energía ${si_o_no(ganador4 === slimeSinEnergía)} pierde (no puede hacerle daño).`, ganador4 == slimeSinEnergía);
    res.write(`El slime sin energía ahora ${si_o_no(slimeSinEnergía.nivel == 2)} tiene nivel 2.`, slimeSinEnergía.nivel == 2);
    res.write(`...Pero ${si_o_no(slimeSinEnergía.energía == 0)} sigue sin energía.`, slimeBalanceado.energía == slimeSinEnergía.energía == 0);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-12)} tiene la misma energía que antes del duelo.`, slimeOfensivo.energía == MAX_ENERGIA-12);
    let ganador5 = slimeDefensivo.duelo(slimeOfensivo);
    res.write(`El slime defensivo reta a duelo al ofensivo y ${si_o_no(ganador5 === slimeDefensivo)} le gana.`, ganador5 == slimeDefensivo);
    res.write(`El slime defensivo ahora ${si_o_no(slimeDefensivo.nivel == 4)} tiene nivel 4.`, slimeDefensivo.nivel == 4);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-39)} perdió otros 27 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-39);
    let ganador6 = slimeSinEnergía.duelo(slimeOfensivo);
    res.write(`El slime sin energía reta a duelo al ofensivo y ${si_o_no(ganador6 === slimeOfensivo)} pierde (no puede hacerle daño).`, ganador6 == slimeOfensivo);
    res.write(`El slime ofensivo ahora ${si_o_no(slimeOfensivo.nivel == 2)} tiene nivel 2.`, slimeOfensivo.nivel == 2);
}

// Test Ejercicio 5
function testEjercicio5(res) {
    let slimeOfensivo = new Slime(20, 10);
    let slimeDesinflado = new Slime(0, 0);
    let slimeBalanceado = new Slime(15, 15);
    slimeOfensivo.nivel = 2;
    slimeBalanceado.nivel = 2;
    slimeOfensivo.actualizarEnergía(-39);
    slimeBalanceado.actualizarEnergía(-13);
    let slimeSanador = new SlimeSanador(10, 15, 20);
    slimeSanador.curar(slimeOfensivo);
    res.write(`El slime sanador cura al ofensivo, quien ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-19)} recupera 20 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-19);
    slimeSanador.curar(slimeBalanceado);
    res.write(`El slime sanador cura al balanceado, quien ${si_o_no(slimeBalanceado.energía == MAX_ENERGIA)} recupera 13 puntos de energía.`, slimeBalanceado.energía == MAX_ENERGIA);
    slimeOfensivo.duelo(slimeSanador);
    res.write(`El slime ofensivo reta a duelo al sanador y ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA-5)} recupera 14 puntos de energía.`, slimeOfensivo.energía == MAX_ENERGIA-5);
    slimeSanador.curar(slimeSanador);
    res.write(`El slime sanador se cura y ${si_o_no(slimeSanador.energía == MAX_ENERGIA-2)} recupera 20 puntos de energía.`, slimeSanador.energía == MAX_ENERGIA-2);
    slimeDesinflado.duelo(slimeSanador);
    res.write(`El slime desinflado reta a duelo al sanador y ${si_o_no(slimeDesinflado.energía == 0)} se queda sin energía.`, slimeDesinflado.energía == 0);
    res.write(`El slime sanador ${si_o_no(slimeSanador.energía == MAX_ENERGIA)} se recuperó por completo.`, slimeSanador.energía == MAX_ENERGIA);
    slimeSanador.curar(slimeDesinflado);
    res.write(`El slime sanador cura al desinflado, quien ${si_o_no(slimeDesinflado.energía == MAX_ENERGIA-60)} recupera 40 puntos de energía.`, slimeDesinflado.energía == MAX_ENERGIA-60);
}
    
    
// Test Ejercicio 6
function testEjercicio6(res) {
    //Tests propios:
    
    res.write("TESTS PROPIOS: ")
    let juan = new Slime(10,20)
    let b = juan.esDescendienteDe(juan) //deberia dar false
    res.write(`Juan, el slime, ${si_o_no(b)} es descendiente de si mismo.`,!b)
    res.write("---------------------------------------------------------------", )
    //Todos los slimes como quedaron hasta ahora.
    let slimeOfensivo = new Slime(20, 10);
    let slimeDesinflado = new Slime(0, 0);
    let slimeBalanceado = new Slime(15, 15);
    let slimeSanador = new SlimeSanador(10, 15, 20);
    let slimeDefensivo = new Slime(10, 20);
    let slimeSinEnergía = new Slime(20, 20);
    slimeOfensivo.nivel = 2;
    slimeBalanceado.nivel = 2;
    slimeDefensivo.nivel = 4;
    slimeSanador.nivel = 2;
    slimeDesinflado.actualizarEnergía(-60);
    slimeOfensivo.actualizarEnergía(-5);
    slimeSinEnergía.energía = 0;
    let intento1 = slimeSinEnergía.reproducirse();
    res.write(`El slime sin energía intenta reproducirse pero ${si_o_no(intento1 === undefined)} le falta energía.`, intento1 === undefined);
    let intento2 = slimeDesinflado.reproducirse();
    res.write(`El slime desinflado intenta reproducirse pero ${si_o_no(intento2 === undefined)} le falta energía.`, intento2 === undefined);
    res.write(`El slime desinflado ${si_o_no(slimeDesinflado.energía == MAX_ENERGIA-60)} conserva su energía.`, slimeDesinflado.energía == MAX_ENERGIA-60);
    let slimeOfensivo2 = slimeOfensivo.reproducirse();
    let slimeOfensivo2Bien = (slimeOfensivo2.ataque == 20) && (slimeOfensivo2.defensa == 10) && (slimeOfensivo2.nivel == 1) && (slimeOfensivo2.energía == MAX_ENERGIA);
    res.write(`El slime ofensivo intenta reproducirse y ${si_o_no(slimeOfensivo2Bien)} tiene una cría con los atributos esperados.`, slimeOfensivo2Bien);
    res.write(`El slime ofensivo ${si_o_no(slimeOfensivo.energía == MAX_ENERGIA/2-5)} gastó la energía esperada.`, slimeOfensivo.energía == MAX_ENERGIA-55);
    let slimeDefensivo2 = slimeDefensivo.reproducirse();
    let slimeDefensivo2Bien = (slimeDefensivo2.ataque == 10) && (slimeDefensivo2.defensa == 20) && (slimeDefensivo2.nivel == 1) && (slimeDefensivo2.energía == MAX_ENERGIA);
    res.write(`El slime defensivo intenta reproducirse y ${si_o_no(slimeDefensivo2Bien)} tiene una cría con los atributos esperados.`, slimeDefensivo2Bien);
    res.write(`El slime defensivo ${si_o_no(slimeDefensivo.energía == MAX_ENERGIA*3/4)} gastó la energía esperada.`, slimeDefensivo.energía == MAX_ENERGIA*3/4);
    let slimeSanador2 = slimeSanador.reproducirse();
    let slimeSanador2Bien = (slimeSanador2.ataque == 10) && (slimeSanador2.defensa == 15) && (slimeSanador2.nivel == 1) && (slimeSanador2.energía == MAX_ENERGIA) && (slimeSanador2.poder == 20);
    res.write(`El slime sanador intenta reproducirse y ${si_o_no(slimeSanador2Bien)} tiene una cría con los atributos esperados.`, slimeSanador2Bien);
    res.write(`El slime defensivo ${si_o_no(slimeSanador.energía == MAX_ENERGIA/2)} gastó la mitad de sus puntos de energía.`, slimeSanador.energía == MAX_ENERGIA/2);
    let intento3 = slimeSanador2.reproducirse();
    res.write(`La cría del slime sanador intenta reproducirse pero ${si_o_no(intento3 === undefined)} le falta energía.`, intento3 === undefined);
    slimeSanador2.duelo(slimeDesinflado);
    let slimeSanador3 = slimeSanador2.reproducirse();
    res.write(`Luego de retar a duelo al slime desinflado, la cría del slime sanador ${si_o_no(slimeSanador3 !== undefined)} logra reproducirse.`, slimeSanador3 !== undefined);
    let todosLosSlimes = new Array(slimeOfensivo, slimeDesinflado, slimeBalanceado, slimeSanador, slimeDefensivo, slimeSinEnergía, slimeOfensivo2, slimeDefensivo2, slimeSanador2, slimeSanador3);
    function curarSiEsDescendiente(sanador, otro) {
        if (sanador.esDescendienteDe(otro)) {
            sanador.curar(otro);
        }
    }    
    todosLosSlimes.map((e) => curarSiEsDescendiente(slimeSanador3, e));
    let curaciónCorrecta = (slimeOfensivo.energía == MAX_ENERGIA-55) && (slimeDesinflado.energía == 0) && (slimeBalanceado.energía == MAX_ENERGIA) && (slimeSanador.energía == MAX_ENERGIA/2+20) && (slimeDefensivo.energía == MAX_ENERGIA*3/4) && (slimeSinEnergía.energía == 0) && (slimeOfensivo2.energía == MAX_ENERGIA) && (slimeDefensivo2.energía == MAX_ENERGIA) && (slimeSanador2.energía == MAX_ENERGIA/2+20) && (slimeSanador3.energía == MAX_ENERGIA);
    res.write(`El nuevo slime sanador ${si_o_no(curaciónCorrecta)} cura correctamente a todos sus antepasados.`, curaciónCorrecta);
    function cantDescendientes(slime) {
        return todosLosSlimes.reduce((res, e) =>res + (e.esDescendienteDe(slime) ? 1 : 0), 0);
    }
    res.write(`El slime ofensivo ${si_o_no(cantDescendientes(slimeOfensivo) == 1)} tiene un descendiente.`, cantDescendientes(slimeOfensivo) == 1);
    res.write(`El slime defensivo ${si_o_no(cantDescendientes(slimeDefensivo) == 1)} tiene un descendiente.`, cantDescendientes(slimeDefensivo) == 1);
    res.write(`El slime balanceado ${si_o_no(cantDescendientes(slimeBalanceado) != 0)} tiene descendencia.`, cantDescendientes(slimeDefensivo) == 1);
    res.write(`El slime sanador ${si_o_no(cantDescendientes(slimeSanador) == 2)} tiene dos descendientes.`, cantDescendientes(slimeBalanceado) == 0);
}




while( true )
{

    // Cambia dentro de las comillas el archivos que quieres que
    // quede en loop, al salvar se actualiza con cada 8 beats.
	Machine.add(me.dir()+"/liveCode.ck") => int fileID;

    8000::ms  => now; // BUG: si voy de un tempo alto a uno bajo hay un salto en la primera vuelta
	Machine.replace( fileID, "liveCode.ck");
	Machine.remove( fileID );


}

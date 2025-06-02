package Modelo;

import java.util.Date;

public class Egresos {
    private int movimientoId;
    private String noRequisicion;
    private String servicio;
    private String observaciones;
    private Date fecha;

    public Egresos() {}

    public Egresos(String noRequisicion, String servicio, String observaciones) {
        this.noRequisicion = noRequisicion;
        this.servicio = servicio;
        this.observaciones = observaciones;
    }

    public int getMovimientoId() {
        return movimientoId;
    }

    public void setMovimientoId(int movimientoId) {
        this.movimientoId = movimientoId;
    }

    public String getNoRequisicion() {
        return noRequisicion;
    }

    public void setNoRequisicion(String noRequisicion) {
        this.noRequisicion = noRequisicion;
    }

    public String getServicio() {
        return servicio;
    }

    public void setServicio(String servicio) {
        this.servicio = servicio;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}
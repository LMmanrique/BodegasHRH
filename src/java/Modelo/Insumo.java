/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author Manrique Matias
 */
public class Insumo {
    private int id;
    private int renglon;
    private int codinsumo;
    private String nombre;
    private String caracteristicas;
    private String npresentacion;
    private String mpresentacion;
    private int codpresentacion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRenglon() {
        return renglon;
    }

    public void setRenglon(int renglon) {
        this.renglon = renglon;
    }

    public int getCodinsumo() {
        return codinsumo;
    }

    public void setCodinsumo(int codinsumo) {
        this.codinsumo = codinsumo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(String caracteristicas) {
        this.caracteristicas = caracteristicas;
    }

    public String getNpresentacion() {
        return npresentacion;
    }

    public void setNpresentacion(String npresentacion) {
        this.npresentacion = npresentacion;
    }

    public String getMpresentacion() {
        return mpresentacion;
    }

    public void setMpresentacion(String mpresentacion) {
        this.mpresentacion = mpresentacion;
    }

    public int getCodpresentacion() {
        return codpresentacion;
    }

    public void setCodpresentacion(int codpresentacion) {
        this.codpresentacion = codpresentacion;
    }
    
    
}

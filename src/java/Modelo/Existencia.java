package Modelo;

public class Existencia {
    private int id;
    private String codbarras;
    private int renglon;
    private int codinsumo;
    private String nombre;
    private String caracteristicas;
    private String npresentacion;
    private String mpresentacion;
    private int codpresentacion;
    private double cantidad_actual;
    private double precio_unitario;

    // Getters y Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCodbarras() {
        return codbarras;
    }

    public void setCodbarras(String codbarras) {
        this.codbarras = codbarras;
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

    public double getCantidad_actual() {
        return cantidad_actual;
    }

    public void setCantidad_actual(double cantidad_actual) {
        this.cantidad_actual = cantidad_actual;
    }

    public double getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(double precio_unitario) {
        this.precio_unitario = precio_unitario;
    }
    
}
package Modelo;

import java.math.BigDecimal;
import java.util.Date;

public class InformeExistencia {
    private int renglon;
    private int codinsumo;
    private String nombreProducto;
    private String lote;
    private Date fechaVencimiento;
    private BigDecimal cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal total;

    public InformeExistencia() {}

    // Getters y Setters
    public int getRenglon() { return renglon; }
    public void setRenglon(int renglon) { this.renglon = renglon; }

    public int getCodinsumo() { return codinsumo; }
    public void setCodinsumo(int codinsumo) { this.codinsumo = codinsumo; }

    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombreProducto) { this.nombreProducto = nombreProducto; }

    public String getLote() { return lote; }
    public void setLote(String lote) { this.lote = lote; }

    public Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

    public BigDecimal getCantidad() { return cantidad; }
    public void setCantidad(BigDecimal cantidad) { this.cantidad = cantidad; }

    public BigDecimal getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(BigDecimal precioUnitario) { this.precioUnitario = precioUnitario; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }
}
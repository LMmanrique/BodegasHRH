package Modelo;
import java.math.BigDecimal;
import java.util.Date;

public class MovimientoInsumo {
    private int movimiento;
    private Date fecha;
    private String numeroFactura;
    private String proveedor;
    private String noRequisicion;
    private String servicio;
    private BigDecimal cantidad;
    private BigDecimal precioUnitario;
    private Date fechaVencimiento;
    private String lote;
    private String tipoMovimiento;
    
    // Constructor vacío
    public MovimientoInsumo() {}
    
    // Constructor completo
    public MovimientoInsumo(int movimiento, Date fecha, String numeroFactura, String proveedor,
                           String noRequisicion, String servicio, BigDecimal cantidad, 
                           BigDecimal precioUnitario, Date fechaVencimiento, String lote, String tipoMovimiento) {
        this.movimiento = movimiento;
        this.fecha = fecha;
        this.numeroFactura = numeroFactura;
        this.proveedor = proveedor;
        this.noRequisicion = noRequisicion;
        this.servicio = servicio;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.fechaVencimiento = fechaVencimiento;
        this.lote = lote;
        this.tipoMovimiento = tipoMovimiento;
    }
    
    // Getters y Setters
    public int getMovimiento() { return movimiento; }
    public void setMovimiento(int movimiento) { this.movimiento = movimiento; }
    
    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }
    
    public String getNumeroFactura() { return numeroFactura; }
    public void setNumeroFactura(String numeroFactura) { this.numeroFactura = numeroFactura; }
    
    public String getProveedor() { return proveedor; }
    public void setProveedor(String proveedor) { this.proveedor = proveedor; }
    
    public String getNoRequisicion() { return noRequisicion; }
    public void setNoRequisicion(String noRequisicion) { this.noRequisicion = noRequisicion; }
    
    public String getServicio() { return servicio; }
    public void setServicio(String servicio) { this.servicio = servicio; }
    
    public BigDecimal getCantidad() { return cantidad; }
    public void setCantidad(BigDecimal cantidad) { this.cantidad = cantidad; }
    
    public BigDecimal getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(BigDecimal precioUnitario) { this.precioUnitario = precioUnitario; }
    
    public Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }
    
    public String getLote() { return lote; }
    public void setLote(String lote) { this.lote = lote; }
    
    public String getTipoMovimiento() { return tipoMovimiento; }
    public void setTipoMovimiento(String tipoMovimiento) { this.tipoMovimiento = tipoMovimiento; }
}
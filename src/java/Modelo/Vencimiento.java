package Modelo;

import java.util.Date;
import java.math.BigDecimal;

/**
 * Modelo para representar la información de un vencimiento y lote.
 */
public class Vencimiento {
    private int id;                     // PK de vencimientos
    private int detalleId;             // FK a detalle_movimiento.id
    private Date fechaVencimiento;     // Fecha de vencimiento, null si no aplica
    private String lote;               // Código de lote, null si no aplica
    private BigDecimal cantidad;       // Stock disponible para este lote/fecha
    private String insumo;             // Nombre del insumo
    private String caracteristicas;    // Características del insumo
    private String usuario;            // Usuario que realizó el movimiento
    private Date creadoEn;             // Timestamp de creación

    public Vencimiento() {}

    // getters & setters...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDetalleId() { return detalleId; }
    public void setDetalleId(int detalleId) { this.detalleId = detalleId; }

    public Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

    public String getLote() { return lote; }
    public void setLote(String lote) { this.lote = lote; }

    public BigDecimal getCantidad() { return cantidad; }
    public void setCantidad(BigDecimal cantidad) { this.cantidad = cantidad; }

    public String getInsumo() { return insumo; }
    public void setInsumo(String insumo) { this.insumo = insumo; }

    public String getCaracteristicas() { return caracteristicas; }
    public void setCaracteristicas(String caracteristicas) { this.caracteristicas = caracteristicas; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public Date getCreadoEn() { return creadoEn; }
    public void setCreadoEn(Date creadoEn) { this.creadoEn = creadoEn; }
}
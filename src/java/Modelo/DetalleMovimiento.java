
package Modelo;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Modelo para representar el detalle de un movimiento de insumos.
 */
public class DetalleMovimiento {
    private int id;                          // PK de detalle_movimiento
    private int movimientoId;               // FK a movimientos.id
    private int existenciaId;               // FK a existencias.id
    private BigDecimal cantidad;            // cantidad ingresada o acreditada
    private BigDecimal precioUnitario;      // precio unitario registrado
    private Date creadoEn;                  // timestamp de creación
    private Vencimiento vencimiento;        // fecha y lote, si aplica

    public DetalleMovimiento() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMovimientoId() {
        return movimientoId;
    }

    public void setMovimientoId(int movimientoId) {
        this.movimientoId = movimientoId;
    }

    public int getExistenciaId() {
        return existenciaId;
    }

    public void setExistenciaId(int existenciaId) {
        this.existenciaId = existenciaId;
    }

    public BigDecimal getCantidad() {
        return cantidad;
    }

    public void setCantidad(BigDecimal cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public Date getCreadoEn() {
        return creadoEn;
    }

    public void setCreadoEn(Date creadoEn) {
        this.creadoEn = creadoEn;
    }

    public Vencimiento getVencimiento() {
        return vencimiento;
    }

    public void setVencimiento(Vencimiento vencimiento) {
        this.vencimiento = vencimiento;
    }
}


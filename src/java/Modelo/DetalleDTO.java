/*
 * Clase auxiliar para representar un detalle de egreso
 * Paquete: Modelo
 */
package Modelo;

public class DetalleDTO {
    private int existencia_id;
    private String fecha_vencimiento;
    private String lote;
    private double cantidad;
    private double precio_unitario;

    // Getters y setters
    public int getExistencia_id() { return existencia_id; }
    public void setExistencia_id(int existencia_id) { this.existencia_id = existencia_id; }

    public String getFecha_vencimiento() { return fecha_vencimiento; }
    public void setFecha_vencimiento(String fecha_vencimiento) { this.fecha_vencimiento = fecha_vencimiento; }

    public String getLote() { return lote; }
    public void setLote(String lote) { this.lote = lote; }

    public double getCantidad() { return cantidad; }
    public void setCantidad(double cantidad) { this.cantidad = cantidad; }

    public double getPrecio_unitario() { return precio_unitario; }
    public void setPrecio_unitario(double precio_unitario) { this.precio_unitario = precio_unitario; }
}
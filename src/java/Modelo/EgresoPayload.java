package Modelo;

import java.util.List;

public class EgresoPayload {
    private String usuario;
    private String fecha;
    private String tipo_movimiento;
    private String proveedor;
    private String servicio_devuelve;
    private String observaciones_compra;
    private List<DetalleDTO> detalles;

    // Getters y setters
    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getTipo_movimiento() { return tipo_movimiento; }
    public void setTipo_movimiento(String tipo_movimiento) { this.tipo_movimiento = tipo_movimiento; }

    public String getProveedor() { return proveedor; }
    public void setProveedor(String proveedor) { this.proveedor = proveedor; }

    public String getServicio_devuelve() { return servicio_devuelve; }
    public void setServicio_devuelve(String servicio_devuelve) { this.servicio_devuelve = servicio_devuelve; }

    public String getObservaciones_compra() { return observaciones_compra; }
    public void setObservaciones_compra(String observaciones_compra) { this.observaciones_compra = observaciones_compra; }

    public List<DetalleDTO> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleDTO> detalles) { this.detalles = detalles; }
}
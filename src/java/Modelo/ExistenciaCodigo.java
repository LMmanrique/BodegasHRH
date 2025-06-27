package Modelo;

public class ExistenciaCodigo {
    private int id;
    private int existenciaId;
    private String codigoBarras;
    private String marca;
    // getters y setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExistenciaId() {
        return existenciaId;
    }

    public void setExistenciaId(int existenciaId) {
        this.existenciaId = existenciaId;
    }

    public String getCodigoBarras() {
        return codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }
    
}
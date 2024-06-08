package Backend;
import DAO.clsConsultas;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class clsUsuario {
    public String COD;
    public String NOMBRE;
    public String APELLIDO;
    public String PASS;
    public String ESTATUS;

    // Constructor por defecto
    public clsUsuario() {
    }

    // Constructor parametrizado
    public clsUsuario(String COD, String NOMBRE, String APELLIDO, String PASS, String ESTATUS) {
        this.COD = COD;
        this.NOMBRE = NOMBRE;
        this.APELLIDO = APELLIDO;
        this.PASS = PASS;
        this.ESTATUS = ESTATUS;
    }

    public String getCOD() {
        return COD;
    }

    public void setCOD(String COD) {
        this.COD = COD;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public String getAPELLIDO() {
        return APELLIDO;
    }

    public void setAPELLIDO(String APELLIDO) {
        this.APELLIDO = APELLIDO;
    }

    public String getPASS() {
        return PASS;
    }

    public void setPASS(String PASS) {
        this.PASS = PASS;
    }

    public String getESTATUS() {
        return ESTATUS;
    }

    public void setESTATUS(String ESTATUS) {
        this.ESTATUS = ESTATUS;
    }

    public int fncRegistroU(clsUsuario pUsuario) throws Exception {
        int Resp = 0;
        clsConsultas objConsulta = new clsConsultas();
        if (objConsulta.fncRegistrarU(pUsuario) == 1) {
            Resp = 1;
        }
        return Resp;
    }

    // Método para actualizar el estado de un usuario
    public int updateStatus(String codUsuario, String nuevoEstatus) throws Exception {
        int Resp = 0;
        clsConsultas objConsulta = new clsConsultas();
        if (objConsulta.fncActualizarEstatus(codUsuario, nuevoEstatus) == 1) {
            Resp = 1;
        }
        return Resp;
    }

    // Métodos para encriptar y desencriptar la contraseña
    private static final String SECRET_KEY = "1234567890123456"; // Clave de 16 caracteres

    public String encrypt(String strToEncrypt) {
        try {
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
        } catch (Exception e) {
            throw new RuntimeException("Error al encriptar", e);
        }
    }

    public String decrypt(String strToDecrypt) {
        try {
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
        } catch (Exception e) {
            throw new RuntimeException("Error al desencriptar", e);
        }
    }
}

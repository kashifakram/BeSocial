package elec5619.group3.besocialos.service;

import org.springframework.stereotype.Service;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

@Service
public class CipherService {

    private static final byte[] keyBytes = "elec5619besocial".getBytes();

    public String encrypt(String plainText){
        SecretKeySpec key = new SecretKeySpec(keyBytes, "AES");
        try {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encrypted = cipher.doFinal(plainText.getBytes());
            System.out.println("Encryption input: " + plainText + "; output: "
                    + Base64.getEncoder().encodeToString(encrypted));
            return Base64.getEncoder().encodeToString(encrypted);
        } catch (Exception  e) {
            e.printStackTrace();
        }
        return null;
    }

    public String decrypt(String cipherText){
        SecretKeySpec key = new SecretKeySpec(keyBytes, "AES");
        try {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(cipherText));
            System.out.println("Decryption input: " + cipherText + "; output: "
                    + new String(decrypted));
            return new String(decrypted);
        } catch (Exception  e) {
            e.printStackTrace();
        }
        return null;
    }
}

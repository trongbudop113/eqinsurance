package com.verz.eqinsurance

import android.util.Base64
import android.util.Log
import java.security.MessageDigest
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

object Encryption {
    var plainText = "api1|2019-05-21"
    @Throws(Exception::class)
    fun Test() {
        try {
            val key = "42342332131"
            val IV = byteArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            Log.i("Encryption", "Original Text  : " + plainText)
            val cipherText = encrypt(plainText.toByteArray(), key, IV)
            Log.i(
                "Encryption",
                "Encrypted Text : " + Base64.encodeToString(cipherText, Base64.DEFAULT)
            )
            val decryptedText = decrypt(cipherText, key, IV)
            Log.i("Encryption", "DeCrypted Text : $decryptedText")
        } catch (e: Exception) {
            return  // Always must return something
        }
    }

    @Throws(Exception::class)
    fun getSHA(input: String): ByteArray? {
        return try {
            // Static getInstance method is called with hashing SHA
            val md = MessageDigest.getInstance("SHA-256")
            md.digest(input.toByteArray())
        } // For specifying wrong message digest algorithms
        catch (e: Exception) {
            null
        }
    }

    @Throws(Exception::class)
    fun encrypt(plaintext: ByteArray?, key: String, IV: ByteArray?): ByteArray? {
        return try {
            //Get Cipher Instance
            val cipher =
                Cipher.getInstance("AES/CBC/PKCS5Padding")
            //Create SecretKeySpec
            val keySpec =
                SecretKeySpec(getSHA(key), "AES")
            //Create IvParameterSpec
            val ivSpec = IvParameterSpec(IV)
            //Initialize Cipher for ENCRYPT_MODE
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec)
            //Perform Encryption
            cipher.doFinal(plaintext)
        } catch (e: Exception) {
            null // Always must return something
        }
    }

    @Throws(Exception::class)
    fun decrypt(cipherText: ByteArray?, key: String, IV: ByteArray?): String? {
        return try {
            //Get Cipher Instance
            val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
            //Create SecretKeySpec
            val keySpec = SecretKeySpec(getSHA(key), "AES")
            //Create IvParameterSpec
            val ivSpec = IvParameterSpec(IV)
            //Initialize Cipher for DECRYPT_MODE
            cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec)
            //Perform Decryption
            val decryptedText = cipher.doFinal(cipherText)
            String(decryptedText)
        } catch (e: Exception) {
            null // Always must return something
        }
    }
}
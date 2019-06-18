/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidade;

/**
 *
 * @author Giovani
 */
public class RestEntity {
     private int id;
     private int[] descricao;

    public RestEntity(int id, int[] descricao) {
        this.id = id;
        this.descricao = descricao;
    }
     
     

    public int[] getDescricao() {
        return descricao;
    }

    public void setDescricao(int[] descricao) {
        this.descricao = descricao;
    }

  
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

   
     
     
}

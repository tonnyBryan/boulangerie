package com.boulangerie.model.view;

import com.boulangerie.model.client.Client;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;

public class V_Client_Stat {
    @FK(Client.class)
    @Col("id_client")
    private Client client;
    private double total;

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}

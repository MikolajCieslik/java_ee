package model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class User {

    @NotEmpty
    private String login;
    @NotEmpty
    private String haslo;
    private Integer typ_konta;
    private String imie;
    private String nazwisko;
    private String kod_pocztowy;
    private String miejscowosc;
    private String adres;
    @Size(min = 9, max = 9, message = "Numer ma 9 cyfr")
    private String numer;

    public User(){

    }

    public User(String login, String haslo, Integer typ_konta, String imie, String nazwisko, String kod_pocztowy, String miejscowosc, String adres, String numer){
        this.login = login;
        this.haslo = haslo;
        this.typ_konta = typ_konta;
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.kod_pocztowy = kod_pocztowy;
        this.miejscowosc = miejscowosc;
        this.adres = adres;
        this.numer = numer;
    }

    //TODO: usunac potem ten konstruktor
    public User(String imie, String nazwisko){
        this.imie = imie;
        this.nazwisko = nazwisko;
    }

    public String getImie() {
        return imie;
    }

    public String getNazwisko() {
        return nazwisko;
    }

    public String printName(){
        return this.imie +" "+ this.nazwisko;
    }
    @Override
    public String toString(){
        return imie+" "+nazwisko;
    }

    public void setImie(String imie) {
        this.imie = imie;
    }

    public void setNazwisko(String nazwisko) {
        this.nazwisko = nazwisko;
    }
}

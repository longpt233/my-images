package com.company.team.utils;

public class Word {

    // fields
    private String word;
    private int frequency;

    // constructors
    public Word() {}

    public Word(String word, int i) {
        this.word = word;
        this.frequency = i;
    }

    // getters setters
    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    @Override
    public String toString() {
        return "Word=" + word + " freq=" + frequency;
    }
}

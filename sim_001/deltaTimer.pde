class DeltaTimer {
  public int currentMillis, lastMillis = 0;
  public float delta;

  void update() {
    // Figure out how many millis have passed since the last draw event
    // This ensures physics happen in the pixels/second, regardless of CPU speed/framerates
    currentMillis = 0;
    currentMillis = millis() - lastMillis;
    lastMillis = millis();

    delta = 0;
    delta = currentMillis/1000.0;
  }
}
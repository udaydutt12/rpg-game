class MultilineTextBox {
  String prompt;
  String[] text;
  int xpos;
  int ypos;
 
  boolean alreadyPressed;
  boolean selecting;
  int xpos2;
  int ypos2;
 
  PVector loc;
 
  float WIDTH;
  float HEIGHT;
 
  boolean inverseBackground;
  boolean hasFocus;
  boolean hasInputFocus;
 
  int lastPress = -500;
 
  MultilineTextBox(String prompt, float x, float y, float w, float h) {
    WIDTH = w;
    HEIGHT = h;
 
    this.prompt = prompt;
    text = new String[1];
    text[0] = "";
    ypos = 0;
    xpos = 0;
 
    loc = new PVector(x, y);
  }
 
  MultilineTextBox(String prompt, float x, float y, float w, float h, boolean inverseBackground) {
    WIDTH = w;
    HEIGHT = h;
 
    this.prompt = prompt;
    text = new String[1];
    text[0] = "";
    ypos = 0;
    xpos = 0;
 
    loc = new PVector(x, y);
 
    this.inverseBackground = inverseBackground;
  }
 
  void update() {
  }
 
  void updatePress() {
    if (mousePressed) {
      if (mouseX > loc.x && mouseX < loc.x + WIDTH && mouseY > loc.y && mouseY < loc.y + HEIGHT) {
        hasFocus = true;
        hasInputFocus = true;
 
        testPos();
 
        alreadyPressed = true;
      } 
      else {
        hasFocus = (text.length <= 1 && text[0].length() <= 0 ? false : true);
        hasInputFocus = false;
        if (!alreadyPressed) selecting = false;
      }
    }
  }
 
  void updateDrag() {
    if (mouseX > loc.x && mouseX < loc.x + WIDTH && mouseY > loc.y && mouseY < loc.y + HEIGHT) testPos();
    else if (selecting) testPos();
  }
 
  void updateRelease() {
    alreadyPressed = false;
  }
 
  void updateKeys() {
    if (keyPressed) {
      if (key == CODED) {
        if (millis() - lastPress > 0) {
          if (keyCode == LEFT) {
            if (xpos <= 0 && ypos > 0) {
              ypos --;
              xpos = text[ypos].length();
            } 
            else xpos = constrain(xpos - 1, 0, text[ypos].length());
          }
          if (keyCode == RIGHT) {
            if (xpos >= text[ypos].length() && ypos < text.length - 1) {
              ypos ++;
              xpos = 0;
            } 
            else xpos = constrain(xpos + 1, 0, text[ypos].length());
          }
          if (keyCode == UP && ypos > 0) {
            ypos --;
            xpos = constrain(xpos, 0, text[ypos].length());
          }
          if (keyCode == DOWN && ypos < text.length - 1) {
            ypos ++;
            xpos = constrain(xpos, 0, text[ypos].length());
          }
          if (keyCode == KeyEvent.VK_HOME) xpos = 0;
          if (keyCode == KeyEvent.VK_END) xpos = text[ypos].length();
 
          if (!(keyCode == SHIFT)) {
            ypos2 = ypos;
            xpos2 = xpos;
          }
 
          lastPress = millis();
        }
      } 
      else {
        switch(key) {
        case ESC:
        case TAB:
          break;
        case ENTER:
        case RETURN:
          newline();
          break;
        case BACKSPACE:
        case DELETE:
          if (selecting && (ypos != ypos2 || xpos != xpos2)) {
            int minypos = min(ypos, ypos2);
            int maxypos = max(ypos, ypos2);
 
            int minxpos;
            int maxxpos;
 
            if (minypos == maxypos) {
              minxpos = min(xpos, xpos2);
              maxxpos = max(xpos, xpos2);
            } 
            else {
              minxpos = (minypos == ypos ? xpos : xpos2);
              maxxpos = (maxypos == ypos ? xpos : xpos2);
            }
 
            if (minypos == maxypos) text[ypos] = text[ypos].substring(0, minxpos) + text[ypos].substring(maxxpos, text[ypos].length());
            else {
              String combine = text[minypos].substring(0, minxpos) + text[maxypos].substring(maxxpos, text[maxypos].length());
              String[] pre = append(subset(text, 0, minypos), combine);
              text = concat(pre, subset(text, maxypos + 1, text.length - (maxypos + 1)));
            }
 
            ypos = minypos;
            xpos = minxpos;
 
            ypos2 = ypos;
            xpos2 = xpos;
            selecting = false;
 
            lastPress = millis();
          } 
          else {
            if (millis() - lastPress > 0 && xpos > 0) {
              text[ypos] = text[ypos].substring(0, xpos - 1) + text[ypos].substring(xpos, text[ypos].length());
 
              xpos --;
              xpos2 = xpos;
 
              lastPress = millis();
            } 
            else if (ypos > 0 && xpos == 0) {
              int over = text[ypos - 1].length();
              String combine = text[ypos - 1] + text[ypos];
 
              String[] pre = append(subset(text, 0, ypos - 1), combine);
              text = concat(pre, subset(text, ypos + 1, text.length - (ypos + 1)));
 
              ypos --;
              xpos = over;
 
              ypos2 = ypos;
              xpos2 = xpos;
            }
          }
          break;
        default:
          if (selecting && (ypos != ypos2 || xpos != xpos2)) {
            int minypos = min(ypos, ypos2);
            int maxypos = max(ypos, ypos2);
 
            int minxpos;
            int maxxpos;
 
            if (minypos == maxypos) {
              minxpos = min(xpos, xpos2);
              maxxpos = max(xpos, xpos2);
            } 
            else {
              minxpos = (minypos == ypos ? xpos : xpos2);
              maxxpos = (maxypos == ypos ? xpos : xpos2);
            }
 
            if (millis() - lastPress > 0) {
 
              if (minypos == maxypos) text[ypos] = text[ypos].substring(0, minxpos) + key + text[ypos].substring(maxxpos, text[ypos].length());
              else {
                String combine = text[minypos].substring(0, minxpos) + key + text[maxypos].substring(maxxpos, text[maxypos].length());
                String[] pre = append(subset(text, 0, minypos), combine);
                text = concat(pre, subset(text, maxypos + 1, text.length - (maxypos + 1)));
              }
 
              ypos = minypos;
              xpos = minxpos + 1;
 
              ypos2 = ypos;
              xpos2 = xpos;
              selecting = false;
 
              lastPress = millis();
            }
          } 
          else {
            if (millis() - lastPress > 0 && textWidth(text[ypos].substring(0, xpos) + key + text[ypos].substring(xpos, text[ypos].length())) < WIDTH - 8) {
              text[ypos] = text[ypos].substring(0, xpos) + key + text[ypos].substring(xpos, text[ypos].length());
 
              xpos ++;
              xpos2 = xpos;
 
              lastPress = millis();
            }
          }
          break;
        }
      }
    }
  }
 
  void newline() {
    String after = text[ypos].substring(xpos, text[ypos].length());
    text[ypos] = text[ypos].substring(0, xpos);
    text = splice(text, after, ypos + 1);
 
    ypos ++;
    xpos = 0;
 
    ypos2 = ypos;
    xpos2 = xpos;
  }
 
  void testPos() {
    if (alreadyPressed) {
      selecting = true;
 
      ypos2 = int(constrain((mouseY - loc.y) / 12.0, 0, text.length - 1));
 
      for (int i = 0; i < text[ypos2].length(); i ++) {
        if (mouseX - loc.x - 4 <= textWidth(text[ypos2].substring(0, i)) + textWidth(text[ypos2].charAt(i)) / 2) {
          xpos2 = i;
          return;
        }
      }
 
      xpos2 = text[ypos].length();
    } 
    else {
      selecting = false;
 
      ypos = int(constrain((mouseY - loc.y) / 12.0, 0, text.length - 1));
 
      for (int i = 0; i < text[ypos].length(); i ++) {
        if (mouseX - loc.x - 4 <= textWidth(text[ypos].substring(0, i)) + textWidth(text[ypos].charAt(i)) / 2) {
          xpos = i;
          return;
        }
      }
 
      xpos = text[ypos].length();
    }
  }
 
  void display() {
    if (inverseBackground) fill(0);
    else fill(255);
    stroke(0);
    if (hasInputFocus) strokeWeight(2);
    else strokeWeight(1);
    rectMode(CORNER);
 
    rect(loc.x, loc.y, WIDTH, HEIGHT);
 
    textSize(12);
    textAlign(LEFT, TOP);
    if (hasFocus) fill(0);
    else fill(102);
 
    if (hasFocus) {
      for (int i = 0; i < text.length; i ++)
        text(text[i], loc.x + 4, loc.y + 2 + i * 12);
    } 
    else text(prompt, loc.x + 4, loc.y + 2);
 
    ypos = constrain(ypos, 0, text.length);
    ypos2 = constrain(ypos2, 0, text.length);
 
    xpos = constrain(xpos, 0, text[ypos].length());
    xpos2 = constrain(xpos2, 0, text[ypos2].length());
 
    if (selecting && (xpos != xpos2 || ypos != ypos2)) {
      fill(162, 234, 255, 102);
      noStroke();
 
      int minypos = min(ypos, ypos2);
      int maxypos = max(ypos, ypos2);
 
      int minxpos;
      int maxxpos;
 
      if (minypos == maxypos) {
        minxpos = min(xpos, xpos2);
        maxxpos = max(xpos, xpos2);
      } 
      else {
        minxpos = (minypos == ypos ? xpos : xpos2);
        maxxpos = (maxypos == ypos ? xpos : xpos2);
      }
 
      if (minypos == maxypos) rect(loc.x + 4 + textWidth(text[minypos].substring(0, minxpos)), loc.y + 4 + minypos * 12, textWidth(text[maxypos].substring(0, maxxpos)) - textWidth(text[maxypos].substring(0, minxpos)), 12);
      else {
        for (int y = minypos; y <= maxypos; y ++) {
          for (int x = 0; x < text[y].length(); x ++) {
            if ((y == minypos ? x >= minxpos : true) && (y == maxypos ? x < maxxpos : true)) rect(loc.x + 4 + textWidth(text[y].substring(0, x)), loc.y + 4 + y * 12, textWidth(text[y].charAt(x)), 12);
          }
          if (text[y].length() <= 0) rect(loc.x + 4, loc.y + 4 + y * 12, textWidth(" ") / 2, 12);
        }
      }
    } 
    else if (hasInputFocus && millis() / 300 % 2 == 1) line(loc.x + 4 + textWidth(text[ypos].substring(0, xpos)), loc.y + 4 + ypos * 12, (loc.x + 4 + textWidth(text[ypos].substring(0, xpos))), loc.y + 16 + ypos * 12);
  }
 
  String[] getText() {
    return text;
  }
 
  void setText(String toSet) {
    String[] output = new String[0];
    int last = -1;
    for (int i = 0; i < toSet.length(); i ++) {
      if (toSet.charAt(i) == '\n') {
        output = append(output, toSet.substring(last + 1, i));
        last = i;
      }
    }
 
    output = append(output, toSet.substring(last + 1, toSet.length()));
 
    text = output;
  }
 
  String consolidate() {
    String toReturn = "";
    for (int i = 0; i < text.length; i ++) {
      toReturn += text[i];
      if (i < text.length - 1) toReturn += "\n";
    }
 
    return toReturn;
  }
}
void mousePressed()
{
  Vector2D mousePos = new Vector2D(mouseX, mouseY);
  if (mouseButton == LEFT)
  {
    ammo.add(new Ammo(myShip.get(0).pos, mousePos, ammo.size()+1, ammo));
  } else if (mouseButton == CENTER)
  {
  } else if (mouseButton == RIGHT)
  {
    ammo.add(new Missile(myShip.get(0).pos, mousePos, ammo.size()+1, ammo));
  }
}

void keyPressed() 
{
  if(key == 'a') 
  {
     print(ammo); 
  }
}
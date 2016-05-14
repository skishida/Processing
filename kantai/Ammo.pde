public class Ammo extends GameObject
{
  public Ammo(Vector2D startPos, Vector2D aimPos, int i,List<GameObject> list)
  {
    super(i);
    this.startPos = startPos;
    this.aimPos = aimPos;
    startmillis = millis();
    theta = atan2(aimPos.y - startPos.y, aimPos.x - startPos.x);
    velocity.x = v0 * cos(theta);
    velocity.y = -v0 * sin(theta);
    println("added ammo ID:"+ id + ", x:" + velocity.x +"y:" + velocity.y );
    this.listed = list;

    // 当たり判定の作成
    hitArea.edge[0] = new Vector2D(-3.0,-3.0);
    hitArea.edge[1] = new Vector2D(-3.0,3.0);
    hitArea.edge[2] = new Vector2D(3.0,3.0);
    hitArea.edge[3] = new Vector2D(3.0,-3.0);
  }


  protected
    Vector2D startPos = new Vector2D();
    Vector2D aimPos = new Vector2D();
    Vector2D velocity  = new Vector2D();
    float v0 = 300;
    float GRAVITY = 100;
    float SIZE = 3;
    float theta;
    int startmillis;


  @Override
  public void hit(Physics opposite)
  {
    Collided = true;
    println("ammo hit to ship!! ID:" + id + "in list" + listed );
    //delete();
  }

  @Override
  public void update()
  {
    if(!Collided) // あたったあとは場所を変えない
    {
      int pastmillis = millis() - startmillis;
      float pm = pastmillis/1000.0;
      Vector2D prepos = new Vector2D();
      prepos.x = pos.x; // 値渡し
      prepos.y = pos.y;
      pos.x = startPos.x+10 + velocity.x * pm;
      pos.y = startPos.y-10 - velocity.y * pm + GRAVITY * pm * pm;

      for(int i=0;i<4;i++)
      {
        hitArea.edge[i].x += (pos.x - prepos.x);
        hitArea.edge[i].y += (pos.y - prepos.y);
      }
    }
  }

  @Override
  public void show()
  {
    if(!Collided)
    {
      ellipse(pos.x, pos.y, SIZE, SIZE);

      noFill();stroke(204, 102, 0);
      quad( hitArea.edge[0].x, hitArea.edge[0].y,
            hitArea.edge[1].x, hitArea.edge[1].y,
            hitArea.edge[2].x, hitArea.edge[2].y,
            hitArea.edge[3].x, hitArea.edge[3].y
      );
      fill(255);stroke(0);
    }

    if( pos.y > WINDOWSIZE.y)
    {
        delete();
    }
    //println("x:" +pos.x + "y:" + pos.y);
  }

}


public class heavyAmmo extends Ammo
{
  public heavyAmmo(Vector2D startPos, Vector2D aimPos, int i,List<GameObject> list)
  {
    super(startPos, aimPos, i,list);
    v0 *= 0.7;
    velocity.x = v0 * cos(theta);
    velocity.y = -v0 * sin(theta);
  };

}

public class Missile extends Ammo
{
  public Missile(Vector2D startPos, Vector2D aimPos, int i,List<GameObject> list)
  {
    super(startPos, aimPos, i,list);
  };

  @Override
  public void update()
  {
    
    if(!Collided) // あたったあとは場所を変えない
    {
      
      int pastmillis = millis() - startmillis;
      float pm = pastmillis/1000.0;
      velocity.x *= 1.007;
      velocity.y *= 1.007;

      Vector2D prepos = new Vector2D();
      prepos.x = pos.x; // 値渡し
      prepos.y = pos.y;
      pos.x = startPos.x+10 + velocity.x * pm;
      pos.y = startPos.y-10 - velocity.y * pm;

      for(int i=0;i<4;i++)
      {
        hitArea.edge[i].x += (pos.x - prepos.x);
        hitArea.edge[i].y += (pos.y - prepos.y);
      }
      if(pm > 3.5){delete();}
      
    }else{
      delete();
    }
    
  }

}
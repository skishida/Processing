public class Ship extends GameObject
{
  public Ship(float x0, float y0, int i, List<GameObject> list)
  {
    super(i);
    pos.x = x0;
    pos.y = y0;
    this.listed = list;
      
      hitArea.edge[0] = new Vector2D(0.0,0.0);
      hitArea.edge[1] = new Vector2D(0.0,15.0);
      hitArea.edge[2] = new Vector2D(55.0,15.0);
      hitArea.edge[3] = new Vector2D(55.0,0.0);
      
      for(int f=0;f<4;f++)
      {
        hitArea.edge[f].x += pos.x;
        hitArea.edge[f].y += pos.y; 
      }
  }

  @Override
  public void update()
  {
    physics.pos = pos;
    Vector2D prepos = new Vector2D();
    prepos.x = pos.x; // 値渡し
    prepos.y = pos.y;
    for(int i=0;i<4;i++)
    {
      hitArea.edge[i].x += (pos.x - prepos.x);
      hitArea.edge[i].y += (pos.y - prepos.y); 
    }
  }
  

  @Override
  public void show()
  {
    rect(pos.x, pos.y, 55, 15);
    
    noFill();stroke(204, 102, 0);
    quad( hitArea.edge[0].x, hitArea.edge[0].y, 
          hitArea.edge[1].x, hitArea.edge[1].y, 
          hitArea.edge[2].x, hitArea.edge[2].y, 
          hitArea.edge[3].x, hitArea.edge[3].y
    );
    fill(255);stroke(0);
  }

  @Override
  public void hit(Physics opposite)
  {
    println("hit ship!! ID:" + id + "in list" + listed );
    // あたった時のアニメーションとかを仕込む
    // 最後にdelete
    delete();
  }

}
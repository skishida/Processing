public class InterferenceManager
{
  private List< List<GameObject> > man;  // オブジェクトリスト の リスト
  private List<Indices> checkID = new ArrayList<Indices>(); // 衝突判定を行うオブジェクトリストのindexのペア

  InterferenceManager(List< List<GameObject> > man)
  {
    this.man = man;
  }

  private class Indices
  {
    int indices1;
    int indices2;
    Indices(int i1, int i2)
    {
      indices1 = i1;
      indices2 = i2;
    }
  }

  public void test()
  {
    println(man.get(2).size());
  }

  public void addCeckList(int ID1, int ID2)
  {
    checkID.add(new Indices(ID1, ID2));
  }

  public void check()
  {
    
    for (int l=0; l< checkID.size(); l++)
    {
      for (int n=0; n< man.get(checkID.get(l).indices1).size(); n++)
      {
        for (int m=0; m< man.get(checkID.get(l).indices2).size(); m++)
        {
          println( "\n l:" + l +"/ n:"+ n + "/ m:" + m);
          println(checkID.get(l).indices1 + ":" + man.get(checkID.get(l).indices1)); 
          println(checkID.get(l).indices2 + ":" + man.get(checkID.get(l).indices2)); 
          /*
          println( "\n" + checkID.get(l).indices1 +"/"+ checkID.get(l).indices2);
          println( man.get( checkID.get(l).indices1 ) );
          println( man.get( checkID.get(l).indices1 ).get(n));
          */
          GameObject go1 =man.get( checkID.get(l).indices1 ).get(n);
          GameObject go2 =man.get( checkID.get(l).indices2 ).get(m);
          if (checkHitArea(go1, go2) || checkHitArea(go2, go1))
          {
            go1.hit(go2.physics);
            go2.hit(go1.physics);
          };
        }
      }
    }
    
  }

  private boolean checkHitArea(GameObject go1, GameObject go2)
  {
    
    // 中心座標
    Vector2D go1c = new Vector2D();
    Vector2D go2c = new Vector2D();
    for (int i=0; i<4; i++)
    {
      go1c.x +=  go1.hitArea.edge[i].x;
      go1c.y +=  go1.hitArea.edge[i].y;
      go2c.x +=  go2.hitArea.edge[i].x;
      go2c.y +=  go2.hitArea.edge[i].y;
    }
    go1c.x /= 4.0;
    go1c.y /= 4.0;
    go2c.x /= 4.0;
    go2c.y /= 4.0;

    // go1の中心から四つ角へのベクトル
    Vector2D go1_v[] = new Vector2D[4];
    for (int i=0; i<4; i++)
    {
      go1_v[i] = new Vector2D();
    }
    for (int i=0; i<4; i++)
    {
      go1_v[i].x = go1.hitArea.edge[i].x - go1c.x;
      go1_v[i].y = go1.hitArea.edge[i].y - go1c.y;
      //stroke(0,255,0);line(go1c.x, go1c.y, go1.hitArea.edge[i].x ,go1.hitArea.edge[i].y);stroke(0);
    }

    // go1の中心から[go2の]四つ角へのベクトル
    Vector2D go2_v[] = new Vector2D[4];
    for (int i=0; i<4; i++)
    {
      go2_v[i] = new Vector2D();
    }
    for (int i=0; i<4; i++)
    {
      go2_v[i].x = go2.hitArea.edge[i].x - go1c.x;
      go2_v[i].y = go2.hitArea.edge[i].y - go1c.y;
      //stroke(255,0,0);line(go1c.x, go1c.y, go2.hitArea.edge[i].x ,go2.hitArea.edge[i].y);stroke(0);
    }


    float[] s = new float[16];
    float[] t = new float[16];
    float[] a = new float[16];
    float[] b_s = new float[16];
    float[] b_t = new float[16];

    int cnt=0;
    for (int m = 0; m<4; m++)
    {
      int m1 = m+1;
      if (m1 == 4) m1 = 0;
      for (int n=0; n<4; n++)
      {
        a[cnt] = go1_v[m].x * go1_v[m1].y - go1_v[m].y * go1_v[m1].x;
        b_s[cnt] = go1_v[m1].y * go2_v[n].x - go1_v[m1].x * go2_v[n].y;
        b_t[cnt] = go1_v[m].x * go2_v[n].y - go1_v[m].y * go2_v[n].x;

        s[cnt] = b_s[cnt]/a[cnt];
        t[cnt] = b_t[cnt]/a[cnt];

        if (s[cnt]>0.0 && t[cnt]>0.0)
        {
          if ( (s[cnt]+t[cnt])<= 1.0 ) 
          {
            /*
             println(cnt);
             print(a[cnt] + "\n");
             print(b_s[cnt] + "/" + b_t[cnt] + "\n");
             print(s[cnt] + "/" + t[cnt] + "\n");
             stroke(0,0,255);
             line(go1c.x, go1c.y, go1.hitArea.edge[m].x ,go1.hitArea.edge[m].y);
             line(go1c.x, go1c.y, go1.hitArea.edge[m1].x ,go1.hitArea.edge[m1].y);
             line(go1c.x, go1c.y, go2.hitArea.edge[m].x ,go2.hitArea.edge[m].y);
             line(go1c.x, go1c.y, go2.hitArea.edge[m1].x ,go2.hitArea.edge[m1].y);
             stroke(0);
             */
            return true;
          }
        }

        cnt++;
      }
    }
    return false;
  }
  
}
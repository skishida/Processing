import java.util.*;

InterferenceManager iMan;

List<GameObject> myShip = new ArrayList<GameObject>();
List<GameObject> enemyShip = new ArrayList<GameObject>();
List<GameObject> ammo = new ArrayList<GameObject>(40);

List< List<GameObject> > objectlist = new ArrayList< List<GameObject> >();


int ATARI = 10;
int winx=1200,winy=800;
Vector2D WINDOWSIZE = new Vector2D(winx,winy);

void setup()
{
  size( 1200, 800);
  background(255);

  myShip.add(0, new Ship( 100.0, 400.0, 0, myShip) );

  for(int i=0; i<10 ; i++)
  {
    enemyShip.add(i, new Ship( 300 + i*60, 400, i, enemyShip) ) ;
  }

  // 
  objectlist.add(0, myShip);
  objectlist.add(1, enemyShip);
  objectlist.add(2, ammo);

  // 衝突の干渉設定
  iMan = new InterferenceManager(objectlist);
  //iMan.addCeckList(2,0);
  iMan.addCeckList(2,1);
  
}

void draw()
{
  background(255);

  for(int i=0; i< objectlist.size() ; i++)
  {
    for(int l=0; l< objectlist.get(i).size() ; l++)
    {
      objectlist.get(i).get(l).update();
    }
  }
  
  ///println(ammo); 
  iMan.check();
  
  for(int i=0; i< objectlist.size() ; i++)
  {
    for(int l=0; l< objectlist.get(i).size() ; l++)
    {
      objectlist.get(i).get(l).show();
    }
  }
}
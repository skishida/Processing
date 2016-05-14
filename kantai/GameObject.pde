/* すべての親クラス */
abstract class GameObject
{
  
  GameObject(int i)
  {
    id = i;
  }

  /* 位置などの情報を更新 */
  public abstract void update(); 
  
  /* 描画内容を記述する */
  // update() のあとに呼ばれる
  public abstract void show();
  
  /* 他のオブジェクトとの衝突時の動作 */
  // 最終的に Collided = true にするべき
  public abstract void hit(Physics opposite);
  
  /* リストから自身を削除する */  
  public void delete()
  {
    println("deleted ID:" + id + ", from :" + listed);
    listed.remove(this); // 自らを削除
  }

  public 
    int id;
    Collision hitArea = new Collision(); // 衝突判定用の四角形の座標 quad() で表せる形
    Physics physics = new Physics(); // 物理情報(予定)
    Vector2D pos = new Vector2D(); // 現在位置
    PImage image;

  protected 
    boolean Collided = false;
    List<GameObject> listed;

  public int getID(){ return id;}
  

}

class Physics
{
  Vector2D vel;
  Vector2D pos;
  float mass;
}

class Collision
{
  Vector2D edge[] = new Vector2D[4];
  Collision()
  {
    for(int i=0;i<4;i++)
    {
      edge[i] = new Vector2D();
    }
  }
}
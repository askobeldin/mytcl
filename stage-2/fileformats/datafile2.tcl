# http://gener8.be/site/articles/tcl_file_formats/tcl_file_formats.html
#
# Description of an object-oriented video game
System VideoGame {
  System Maze {
    System Walls {
      Object WallGenerator
      Object TextureMapper
    }
    System Monsters {
      Object FightingEngine
      Object MonsterManipulator
    }
  }
  System Scores {
    Object ScoreKeeper
  }

  System "mysystem epta" {
      System "inner one" {
          System "inner two" {
              System "inner three" {
                  Object one
                  Object two
                  Object three
              }
              Object two-1
          }
          Object inner-1
          Object inner-2
          Object inner-3
          Object inner-4
          Object inner-5
      }
  }
}

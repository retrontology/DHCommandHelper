proc(_main, @centerBlock, @counter)
{
  if(@counter > 3, return())
  @chance = rand(0,100)
  if(@chance < 20)
  {
    # Let the walls crumble... CAVE IN!!!
    @blocks = array()
    # At x + 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1], 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y], z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1], 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y], z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At y + 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] + 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] + 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At y - 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] - 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] - 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At z + 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1], 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y], z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At z + 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1], 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y], z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, y + 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] + 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, y - 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] - 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, z + 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1], 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y], z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, z - 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1], 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y], z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y + 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] + 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y - 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2], 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] - 1, z:@centerBlock[z], 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, z + 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1], 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y], z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, z - 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1], 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y], z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At z + 1, y + 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] + 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] + 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])    
    # At z + 1, y - 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] - 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] - 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At z - 1, y + 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] + 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] + 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At z - 1, y - 1
    @blocks[] = array(0:@centerBlock[0], 1:@centerBlock[1] - 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x], y:@centerBlock[y] - 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y + 1, z + 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] + 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y + 1, z - 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] + 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y - 1, z + 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] - 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x + 1, y - 1, z - 1
    @blocks[] = array(0:@centerBlock[0] + 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] + 1, y:@centerBlock[y] - 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, y + 1, z + 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] + 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, y + 1, z - 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] + 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] + 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    # At x - 1, y - 1, z + 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2] + 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] - 1, z:@centerBlock[z] + 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])    
    # At x - 1, y - 1, z - 1
    @blocks[] = array(0:@centerBlock[0] - 1, 1:@centerBlock[1] - 1, 2:@centerBlock[2] - 1, 
                      3:'Hammerlea', 4:@centerBlock[4], 5:@centerBlock[5],
                      x:@centerBlock[x] - 1, y:@centerBlock[y] - 1, z:@centerBlock[z] - 1, 
                      world:'Hammerlea', pitch:@centerBlock['pitch'], yaw:@centerBlock['yaw'])
    _crumble(@blocks)
    @counter++
    @newCenterBlock = array_rand(@blocks, 1, false)
    _main(@newCenterBlock[0],@counter)
  }
}

proc(_crumble, @blocks)
{
  foreach(@block in @blocks)
  {
    @blockDataString = get_block_at(@block[x], @block[y], @block[z], @block[world])
    @blockData = split(':',@blockDataString)
    if(@blockData[0] == '1') #If the block is stone or some derivitive of it...
    {
      set_block_at(@block[x], @block[y], @block[z], 4, @block[world])
    }
  }
}
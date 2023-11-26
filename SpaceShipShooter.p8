-- Shooting Game in Pico-8

-- Player Spaceship
player = {
  x = 60,
  y = 120,
  speed = 2,
}

-- Bullets
bullets = {}

-- Enemies
enemies = {}

-- Function to create a new bullet
function createBullet(x, y)
  local bullet = {
    x = x,
    y = y,
    speed = 3,
  }
  table.insert(bullets, bullet)
end

-- Function to create a new enemy
function createEnemy()
  local enemy = {
    x = math.random(0, 120),
    y = 0,
    speed = 1,
  }
  table.insert(enemies, enemy)
end

-- Main update function
function _update()
  -- Player controls
  if btn(0) then  -- Left
    player.x = player.x - player.speed
  elseif btn(1) then  -- Right
    player.x = player.x + player.speed
  end

  -- Shooting
  if btn(4) then  -- Z key to shoot
    createBullet(player.x + 4, player.y)
  end

  -- Update bullets
  for i, bullet in ipairs(bullets) do
    bullet.y = bullet.y - bullet.speed
    if bullet.y < 0 then
      table.remove(bullets, i)
    end
  end

  -- Update enemies
  for i, enemy in ipairs(enemies) do
    enemy.y = enemy.y + enemy.speed
    if enemy.y > 128 then
      table.remove(enemies, i)
    end
  end

  -- Spawn new enemies
  if rnd() < 0.02 then
    createEnemy()
  end

  -- Check for collisions between bullets and enemies
  for i, bullet in ipairs(bullets) do
    for j, enemy in ipairs(enemies) do
      if
        bullet.x < enemy.x + 8 and
        bullet.x + 1 > enemy.x and
        bullet.y < enemy.y + 8 and
        bullet.y + 3 > enemy.y
      then
        -- Remove both the bullet and the enemy on collision
        table.remove(bullets, i)
        table.remove(enemies, j)
      end
    end
  end
end

-- Main draw function
function _draw()
  -- Clear the screen
  cls()

  -- Draw player spaceship
  rect(player.x, player.y, 8, 8, 7)

  -- Draw bullets
  for _, bullet in ipairs(bullets) do
    rect(bullet.x, bullet.y, 1, 3, 11)
  end

  -- Draw enemies
  for _, enemy in ipairs(enemies) do
    rect(enemy.x, enemy.y, 8, 8, 6)
  end
end

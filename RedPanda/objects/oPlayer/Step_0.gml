// Inputs

rightKey = keyboard_check(vk_right);
leftKey = keyboard_check_direct(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);
jumpKeyHold = keyboard_check(vk_space);



//Getting xspd and yspd
	//Xspd based on button presses
	var dir = rightKey - leftKey;
	
		xspd += dir*accel;
		
		if(dir == 0) // Slowing down character
		{
		
			// Going left
			if (xspd < 0)
			{
				xspd = min(xspd + decel, 0); 
			}
			else 
			{
				xspd = max(xspd - decel, 0);
			}
		}
		
	//apply gravit to yspd
	yspd += grav;
	
	
	
	//Jumping
		//Rest the jump Count
		if place_meeting(x, y+1, obj_o_wall)
		{
			jumpCount = 0;
			sprite_index = sPlayer_Run;
		}
		else
		{
			//Take away the first jump if the player is in the air
			if jumpCount == 0
			{
				jumpCount = 1;
		
			}
		}
		
		
		// Initiate our jump
		if jumpKeyPressed && jumpCount < jumpMax
		{
				if jumpKeyPressed
				{
					sprite_index = sPlayer_Jump;
				}
	
			sprite_index = sPlayer_Jump;
			
			//Count jumps
			jumpCount++;
			
			
			// Set the jump timer
			jumpTimer = jumpHoldFrames;
		}
		
		if jumpCount = 2
			{
				sprite_index = sPlayer_Spin_Jump;
			}
		
		
		
		// End the jump early by stopping the timer if the jump button is not being held
		if !jumpKeyHold { jumpTimer = 0; };
		
		// Jump based on the timer
		if jumpTimer > 0
		{
			// Constantly set the yspd to be the jumpSpd
			yspd = jumpSpd;
			
		
			//Count down the timer
			jumpTimer--;
		}
	
//Collisions
	
	//X Collision
	if place_meeting(x + xspd, y, obj_o_wall)
	{
		// Move to the wall
		var _pixelCheck = sign(xspd);
		while !place_meeting(x + _pixelCheck, y, obj_o_wall)
		{
			x += _pixelCheck;
			
		}
		
		//Set speed to zero
		xspd = 0;
	}
	
	
	
	
	
	
	//Y Collision
	if place_meeting(x + xspd, y + yspd, obj_o_wall)
	{
		// Move player as close to the wall as possible
		var _pixelCheck = sign(yspd);
		if (!place_meeting(x + xspd, y + _pixelCheck, obj_o_wall))
		{
			y += _pixelCheck;
			
		}
		
		//Set speed to zero
		yspd = 0;
		
		
	}

// Move the player

	xspd = clamp(xspd, -max_xspd, max_xspd); // Setting max speed


	x += xspd;
	y += yspd;
	
	if xspd = 0
	{
	sprite_index = sPlayer_idle;
	}

	
	if (xspd != 0)
		image_xscale = sign(xspd);
		
	
class KXZSFunctions
{
	static void KXBlueKnightDash(Actor Activator, Double Force)
    {	
		if(!Activator.Player) return;

		Vector2 Acceleration = Activator.RotateVector((Activator.Player.cmd.forwardmove, - Activator.Player.cmd.sidemove), Activator.Angle);
		if(!Acceleration.X  && !Acceleration.Y) 
		Acceleration=Actor.RotateVector((1,0),Activator.Angle);
		Activator.A_SetBlend("White",0.1,20);
		Activator.A_QuakeEx(2,2,2,15,0,1,"",QF_SCALEDOWN);
		
		Activator.Vel.XY += Acceleration.Unit()*Force;
    }
}

Class KXBlueKnightBlocking : Actor
{
  Default
  {
  Radius 96;
  Height 100;
  Mass 99999999;
  Species "Marines";
  DamageFactor "Marines", 0.0;
  PainChance 0;
  Health 9999;
  +REFLECTIVE;
  +MIRRORREFLECT;
  +SHOOTABLE;
  +NORADIUSDMG;
  +NOGRAVITY;
  +NOTELEPORT;
  +DONTRIP;
  +NOBLOODDECALS;
  +THRUSPECIES;
  +NOBLOOD;
  }
  override int DamageMobj (Actor inflictor, Actor source, int damage, Name mod, int flags, double angle)
	{ 
		master = target;
		inflictor.target = master;
		inflictor.bThruSpecies = true;
		inflictor.A_SetSpecies("Marines");
		inflictor.damagetype = "Marines";
		target.A_TakeInventory("KXBlueKnightParryCooldown",1);
		inflictor.A_SpawnItemEx("KXBlueKnightBlockingBlood",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION);
		inflictor.Vel *= 2;
		return super.DamageMobj(inflictor, source, damage, mod, flags, angle);
	}
  states
  {
  Spawn:
    TNT1 A 0;
	TNT1 A 0 A_RadiusGive("KXBlueKnightKatanaExplosion",210,RGF_MONSTERS,1);
    TNT1 A 11;
    Stop;
  }
}

Class KXBlueKnightBlocking2 : KXBlueKnightBlocking
{
  Default
  {
  }
  states
  {
  Spawn:
    TNT1 A 0;
    TNT1 A 11;
    Stop;
  }
}
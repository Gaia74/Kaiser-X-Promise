class ZObliterator : Baronofhell
{ 
  default
  {
  //$Category Barons
  obituary "%o was slaughtered by an obliterator";
  hitobituary "%o was torn asunder by an obliterator";
  health 2000;
  radius 24;
  height 64;
  mass 1000;
  speed 20;
  scale 1.1;
  MeleeRange 66;
  painchance 20;
  seesound "Obliterator/Roar";
  painsound "Obliterator/Pain";
  deathsound "Obliterator/Death";
  activesound "Obliterator/Active";
  translation "16:47=[189,183,107]:[0,0,0]", "112:127=[255,255,255]:[255,0,0]", "48:79=[189,183,107]:[0,0,0]";
  MONSTER;
  +MISSILEMORE;
  +MISSILEEVENMORE;
  +NORADIUSDMG;
  +NOINFIGHTING;
  +NOTARGET;
  +DONTHARMSPECIES;
  Species "KX";
  DamageFactor "KX", 0.0;
  DamageType "KX";
  }
  states
  {
  Spawn:
    CBOS AB 10 A_Look;
    loop;
  See:
	CBOS A 3 A_Chase;
    CBOS A 3 A_Chase;
    CBOS B 0 A_StartSound("cbaron/metal",CHAN_6);
    CBOS BB 3 A_Chase;
    CBOS CCD 3 A_Chase;    
	CBOS D 0 A_StartSound("cbaron/Step",CHAN_7);
	CBOS D 3 A_Chase;
    loop;
  Melee:
    CBOS A 0 A_Jump(48,"MeleeStomp");
    CBOS A 0 { bnopain = true; }
	CBOS A 0 A_StartSound("Obliterator/Attack",CHAN_VOICE);
    CBOS PQ 4 A_FaceTarget;
    CBOS R 4 A_CustomComboAttack("BaronBall", 32, 5 * random(20,40), "baron/melee");
	CBOS A 0 { bnopain = false; }
    Goto See;
  MeleeStomp:
	CBOS A 0 A_StartSound("Obliterator/Attack",CHAN_VOICE);
    CBOS PQ 4 A_FaceTarget;
    CBOS Q 0 A_SpawnItemEx("KXStompEffect",0,0,3,0,0,0,0,SXF_NOCHECKPOSITION);
	TNT1 A 0 A_StartSound("cbaron/Stomp");
	TNT1 A 0 A_Explode(192,192);
	CBOS R 20 A_FaceTarget;
	Goto See;
  InstaMelee:
	CBOS E 0 A_StartSound("cbaron/DashHit",CHAN_ITEM);
    CBOS E 0 A_FaceTarget;
	CBOS E 0 A_Stop;
    CBOS Q 4 A_CustomMeleeAttack(5*random(10,30),"cbaron/DashHit","","Melee",True);
	CBOS RR 4 A_FaceTarget;
    Goto See;
  Missile:
	CBOS E 0 A_JumpIfInventory("CyberHuskObliteratorItem2",1,"FiringStomp");
    CBOS E 0 A_JumpIfCloser (334, "FlameThrower");
	CBOS E 0 A_Jump (256,"Imp","FireShot","Dash","Stomp","JumpingFlames","DashingFire","CircleFire");
	Goto See;
  Imp: 
    CBOS PPPPPPPP 1 A_SpawnItemEx("KXExplosiveFireBallParticle2",0,-44,69,frandom(-1,1),frandom(-1,1),frandom(0,4),random(0,360));
	CBOS P 0 A_FaceTarget;
	CBOS PPPPPPPP 1 A_SpawnItemEx("KXExplosiveFireBallParticle2",0,-44,69,frandom(-1,1),frandom(-1,1),frandom(0,4),random(0,360));
	CBOS Q 8 A_FaceTarget;
	CBOS E 0 A_Jump (256,"One", "Two");
  One:
    CBOS R 0 {
        for(let i = -45; i <= 45; i += 5) {
            A_SpawnProjectile("ObliteratorFireBall1",32,0,i, 0);
        }
    }
	CBOS R 8 A_FaceTarget;
    Goto See;
  Two:
    CBOS RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR 0 A_SpawnProjectile("ObliteratorFireBall2",32,0,random(-30, 30), 0);
	CBOS R 8 A_FaceTarget;
    Goto See;
  FireShot:
    TNT1 A 0 { special1 = 0; }
    CBOS E 5 A_FaceTarget;
    TNT1 A 0 A_JumpIf(++special1==5,"See");
    CBOS F 5 Bright A_SpawnProjectile("ObliteratorShot",32,16,0);
	CBOS E 0 A_Jump(160,"See");
	Goto FireShot+1;
  Dash:
    CBOS P 5 A_FaceTarget;
	CBOS A 0 {
        A_StartSound("Obliterator/Attack",CHAN_VOICE);
        A_StartSound("cbaron/dash",CHAN_7);
    }
	TNT1 A 0 ThrustThingZ(0,10,0,1);
	TNT1 A 0 A_SetAngle(frandom(-1,1)+angle);
	TNT1 A 0 A_Recoil(random(-40,-50));
	TNT1 A 0 A_FaceTarget;
	Goto RealDash;
  RealDash:
    CBOS P 0 A_SpawnItemEx("KXObliteratorDashTrailOne", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS P 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS P 0 A_SpawnItemEx("KXObliteratorDashTrailOne", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS P 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS P 0 A_SpawnItemEx("KXObliteratorDashTrailOne", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS P 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS Q 0 A_SpawnItemEx("KXObliteratorDashTrailTwo", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS Q 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS Q 0 A_SpawnItemEx("KXObliteratorDashTrailTwo", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS Q 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS Q 0 A_SpawnItemEx("KXObliteratorDashTrailTwo", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS Q 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS R 0 A_SpawnItemEx("KXObliteratorDashTrailThree", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS R 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS R 0 A_SpawnItemEx("KXObliteratorDashTrailThree", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS R 1 Bright A_JumpIfCloser(70,"DashCheck");
	CBOS R 0 A_SpawnItemEx("KXObliteratorDashTrailThree", 0, 0, 0, 0, 0, 0, 0, SXF_CLIENTSIDE | SXF_TRANSFERTRANSLATION);
	CBOS R 1 Bright A_JumpIfCloser(70,"DashCheck");
	TNT1 A 0 A_ScaleVelocity(0.2);
	TNT1 A 0 A_Jump(128,"Dash");
    Goto See;
  DashCheck:
    TNT1 A 0 A_JumpIfTargetInsideMeleeRange("InstaMelee");
	Goto See;
  Stomp:
    CBOS A 0 A_StartSound("Obliterator/Roar",CHAN_VOICE);
    CBOS PPPPPA 4 A_FaceTarget;
	Goto Stomping;
  Stomping:
    CBOS P 0 A_FaceTarget;
	CBOS P 0 A_StartSound("cbaron/jump");
	TNT1 A 0 ThrustThingZ(0,random(25,35),0,1);
	TNT1 A 0 A_Recoil(random(-30,-50));
	TNT1 AAAAAAAAAA 0 A_SpawnItemEx("KXArachnobaronDust",0,0,3,random(-6,6),random(-6,6),random(0,1),random(0,360));
	TNT1 A 0 A_FaceTarget;
	Goto StompAnimation;
  StompAnimation:
    CBOS P 1 BRIGHT {
      A_SpawnItemEx("KXObliteratorDashTrailOne",0,0,0,0,0,0,0,SXF_CLIENTSIDE);
      return A_JumpIf(target && Distance3D(target)<=70 || Vel.Z==0,"EndStomp");
    }
    Loop;
  EndStomp:
    CBOS Q 0 A_SpawnItemEx("KXStompEffect",0,0,3,0,0,0,0,SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
	TNT1 A 0 A_StartSound("cbaron/Stomp");
	TNT1 A 0 A_Explode(192,192);
	CBOS R 20 A_ScaleVelocity(0);
	TNT1 A 0 A_Jump(96,"Dash","Stomping");
	Goto See;
  FlameThrower:
	CBOS E 4 A_FaceTarget;
	TNT1 A 0 { 
        special1 = 0; 
        special2 = 0;
    }
	TNT1 A 0 A_StartSound("Hellcubus/FlameThrower",CHAN_VOICE);
	Goto LoopingFlames;
  LoopingFlames:
    CBOS F 1 {
        A_FaceTarget();
        A_SpawnProjectile ("ObliteratorFlames",32,16,sin(special2)*30,0,0);
        special2 += 5;
        return A_JumpIf(++special1==250,"See");
    }
	Loop;
  JumpingFlames:
    CBOS A 0 A_StartSound("Obliterator/Roar",CHAN_VOICE,1.0);
    CBOS CDCDCD 4 A_FaceTarget;
	CBOS P 0 A_StartSound("cbaron/jump");
	TNT1 A 0 ThrustThingZ(0,30,0,1);
	TNT1 A 0 A_Recoil(-35);
	TNT1 AAAAAAAAAA 0 A_SpawnItemEx("KXArachnobaronDust",0,0,3,random(-6,6),random(-6,6),random(0,1),random(0,360));
	TNT1 A 0 A_FaceTarget;
	TNT1 A 0 A_StartSound("Hellcubus/FlameThrower",CHAN_WEAPON);
	Goto FlamesJumping;
  FlamesJumping:
    CBOS F 1 BRIGHT {
      A_SpawnItemEx("KXObliteratorDashTrailFour",0,0,0,0,0,0,0,SXF_CLIENTSIDE|SXF_TRANSFERTRANSLATION);
      A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
      A_FaceTarget();
      return A_JumpIf(target && Distance3D(target)<=70 || Vel.Z==0,"EndFlamesJumping");
    }
    Loop;
  EndFlamesJumping:
	CBOS R 20 A_Stop;
	TNT1 A 0 A_Jump(64,"Dash");
	Goto See;
  DashingFire:
    CBOS P 0 A_JumpIfCloser(375,"RealDashingFire");
	Goto Missile;
  RealDashingFire:
    TNT1 A 0 A_StartSound("cbaron/dash");
    TNT1 A 0 {special1 = randompick(192,64); }
    TNT1 A 0 A_FaceTarget;
	TNT1 A 0 A_StartSound("Hellcubus/FlameThrower",CHAN_WEAPON);
	CBOS E 0 A_FaceTarget;
	CBOS FFF 1 A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
	TNT1 A 0 A_Recoil(-3);
	TNT1 A 0 ThrustThing(angle*256/360+special1, 12, 0, 0);
	CBOS E 0 A_FaceTarget;
	CBOS FFF 1 A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
	CBOS E 0 A_FaceTarget;
	CBOS FFF 1 A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
	TNT1 A 0 A_Recoil(-3);
	TNT1 A 0 ThrustThing(angle*256/360+special1, 12, 0, 0);
	CBOS E 0 A_FaceTarget;
	CBOS FFF 1 A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
	TNT1 A 0 A_Jump (32,"DashingFire");
	Goto See;
  CircleFire:
	CBOS A 0 A_StartSound("Obliterator/Attack",CHAN_VOICE,1.0);
    CBOS E 4 A_FaceTarget;
	TNT1 A 0 { 
        special1 = 0; 
        special2 = randompick(-6,6);
        A_StartSound("Hellcubus/FlameThrower",CHAN_VOICE);
    }
    Goto LoopingCircle;
  LoopingCircle:
	CBOS F 1 {
        A_SpawnProjectile ("ObliteratorFlames",32,16,0,CMF_AIMDIRECTION,0);
        angle += special2;
        A_SpawnProjectile ("ObliteratorFlames",32,16,0,CMF_AIMDIRECTION,0);
        angle += special2;
        return A_JumpIf(++special1==30, "See");
    }
    Loop;
  FiringStomp:
    CBOS A 0 A_StartSound("Obliterator/Roar",CHAN_VOICE,1.0);
    CBOS PPPPPPPPPPPPA 4 A_FaceTarget;
	Goto FiringStomping;
  FiringStomping:
    CBOS P 0 A_FaceTarget;
	CBOS P 0 A_StartSound("cbaron/jump");
	TNT1 A 0 ThrustThingZ(0,random(25,35),0,1);
	TNT1 A 0 A_Recoil(random(-30,-50));
	TNT1 AAAAAAAAAA 0 A_SpawnItemEx("KXArachnobaronDust",0,0,3,random(-6,6),random(-6,6),random(0,1),random(0,360));
	TNT1 A 0 A_FaceTarget;
	Goto FiringStompAnimation;
  FiringStompAnimation:
    CBOS P 1 BRIGHT {
      A_SpawnItemEx("KXObliteratorDashTrailOne",0,0,0,0,0,0,0,SXF_CLIENTSIDE|SXF_TRANSFERTRANSLATION);
      A_SpawnProjectile ("ObliteratorFlames",32,16,0,0,0);
      A_FaceTarget();
      return A_JumpIf(target && Distance3D(target)<=70 || Vel.Z==0,"FiringEndStomp");
    }
	Loop;
 FiringEndStomp:
    CBOS Q 0 A_SpawnItemEx("KXStompEffect",0,0,3,0,0,0,0,SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
	TNT1 BBBBBBBBBB 0 A_SpawnItemEx ("CyberHuskFlames",frandom(0,128),0,1,0,0,0,random(0,360));
	TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx ("CyberHuskNapalm2",0,0,5,frandom(-15,15),frandom(-15,15),frandom(5,15),random(0,360));
	TNT1 AAAAAAAAAAAAA 0 A_SpawnItemEx("KXRocketExplosionEffect",0,0,5,frandom(-5,5),frandom(-5,5),frandom(0,5),random(0,360),SXF_NOCHECKPOSITION);
	TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("KXExplosiveFireBallParticle4",0,0,5,frandom(0,10),frandom(0,10),frandom(5,20),random(0,360),SXF_NOCHECKPOSITION);
	TNT1 A 0 A_StartSound("cbaron/Stomp",CHAN_6,1.0,FALSE,ATTN_NONE);
	TNT1 A 0 A_StartSound("DiaIgnite/explosion",CHAN_7,1.0,FALSE,ATTN_NONE);
	TNT1 A 0 A_Explode(192,224);
	TNT1 A 0 A_TakeInventory("CyberHuskObliteratorItem2",1);
	CBOS R 20 A_ScaleVelocity(0);
	TNT1 A 0 A_Jump(96,"Dash","Stomping");
	Goto See;
  Pain:
    CBOS H 2;
    CBOS H 2 A_Pain;
    goto See;
  Death:
    CBOS HHH 35 A_Scream;
	CBOS K 0 A_StartSound("KXExplosion/Explosion",CHAN_6,1.0);
    CBOS HHHHHHHHHHHHHHHHHHHH 0A_SpawnProjectile("KXSmallExplosionEffect1",random(10,50),random(-4,4),random(0,359),2,random(-10,10));
    CBOS I 8;
    CBOS J 8 A_Scream;
    CBOS K 0 A_StartSound("KXExplosion/Explosion");
	CBOS K 4 bright;
	CBOS A 0 A_SpawnItem ("KXRocketExplosionEffect", 0, 32);
	TNT1 A 0 A_SpawnItemEx("KXCyberBaronExplosionDeathEffect4",0,0,3,0,0,0,0,SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
	TNT1 AAAAAAAAAAAAAA 0 A_SpawnItemEx("KXCyberBaronExplosionDeathEffect1",0,0,1,frandom(-10,10),frandom(-10,10),frandom(0,15),random(1,360));
	TNT1 AAAAAAAAAAAAAA 0 A_SpawnItemEx("KXCyberBaronExplosionDeathEffect2",0,0,1,frandom(-10,10),frandom(-10,10),frandom(0,10),random(1,360));
	CBOS K 4 bright;
    CBOS L 8 bright A_NoBlocking;
    CBOS M 8 bright;
    CBOS N 8 bright;
    CBOS O -1;
    Stop;
   }
}

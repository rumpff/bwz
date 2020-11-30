using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class Player : MonoBehaviour
{
    /** Variables **/
    /* Management */
    private IPlayerPhysicsState thisCurrentState;

    /* Components */
    public Rigidbody2D Rigidbody { get; private set; }


    /** Methods **/
    /* Unity */
    private void Awake()
    {
        // Get Components
        Rigidbody = GetComponent<Rigidbody2D>();
    }
    private void Start()
    {
        SwitchPhysicsState(new PlayerGrounded());
    }
    private void Update()
    {
        // Update states
        thisCurrentState?.OnUpdate();
    }

    private void FixedUpdate()
    {
        // Update states
        thisCurrentState?.OnFixedUpdate();
    }


    /* State management */
    public void SwitchPhysicsState(IPlayerPhysicsState newState)
    {
        thisCurrentState?.OnExit();
        thisCurrentState = newState;
        thisCurrentState?.OnEnter(this);
    }

    /* Physics */
    public void ApplyHorizontalFriction(float frictionAmount)
    {
        Rigidbody.velocity -= new Vector2(Rigidbody.velocity.x, 0).normalized * frictionAmount;
    }

    public void ApplyVerticalFriction(float frictionAmount)
    {
        Rigidbody.velocity -= new Vector2(0, Rigidbody.velocity.y).normalized * frictionAmount;
    }

    public bool GroundCheck()
    {
        return false;
    }

    public bool WallCheck()
    {
        return false;
    }
}

public interface IPlayerPhysicsState
{
    void OnEnter(Player p);
    void OnExit();

    void OnUpdate();
    void OnFixedUpdate();
}

public class PlayerGrounded : IPlayerPhysicsState
{
    private Player thisPlayer;

    public void OnEnter(Player p)
    {
        thisPlayer = p;
    }

    public void OnExit()
    {
        
    }

    public void OnUpdate()
    {
        
    }

    public void OnFixedUpdate()
    {
        
    }
}

public class PlayerAirborne : IPlayerPhysicsState
{
    public void OnEnter(Player p)
    {
        
    }

    public void OnExit()
    {
        
    }

    public void OnUpdate()
    {

    }

    public void OnFixedUpdate()
    {
        
    }
}
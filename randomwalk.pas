program randomwalk;

uses
    SysUtils;

procedure InitWindow(width: LongInt; height: LongInt; title : PAnsiChar); cdecl; external 'raylib.dll';
procedure CloseWindow(); cdecl; external 'raylib.dll';
function WindowShouldClose() : Boolean; cdecl; external 'raylib.dll';
procedure SetTargetFPS(fps : LongInt); cdecl; external 'raylib.dll';
procedure BeginDrawing(); cdecl; external 'raylib.dll';
procedure EndDrawing(); cdecl; external 'raylib.dll';
procedure DrawLine(x1 : LongInt; y1 : LongInt; x2 : LongInt; y2 : LongInt; color: LongInt); cdecl; external 'raylib.dll';

const
    screen_w = 800;
    screen_h = 600;
    scale = 1;
    agents_num = 50;
    target_fps = 5000;

type
    vec2 = record
        x : LongInt;
        y : LongInt
    end;

type
    agent = record
        pos : vec2;
        prev_pos : vec2;
        vel : vec2;
        color : LongInt;
    end;

var
    agents : array[0..agents_num - 1] of agent;
    i : LongInt;

function get_rand_vel() : vec2;
var
    choice : LongInt;
begin
    choice := random(4);
    case choice of
        0:  begin
                get_rand_vel.x := 0;
                get_rand_vel.y := -1;
            end;
        1:  begin
                get_rand_vel.x := 0;
                get_rand_vel.y := 1;
            end;
        2:  begin
                get_rand_vel.x := -1;
                get_rand_vel.y := 0;
            end;
        3:  begin
                get_rand_vel.x := 1;
                get_rand_vel.y := 0;
            end;
    end;
end;

begin
    InitWindow(screen_w, screen_h, 'random walk');
    SetTargetFPS(target_fps);
    Randomize;

    for i := 0 to agents_num - 1 do
    begin
        agents[i].pos.x := 400;
        agents[i].pos.y := 300;
        agents[i].color := $FF000000 + (random(256) shl 16) + (random(256) shl 8) + random(256);
    end;

    while not WindowShouldClose() do
    begin
        BeginDrawing();

            for i := 0 to agents_num - 1 do
            begin
                agents[i].prev_pos.x := agents[i].pos.x;
                agents[i].prev_pos.y := agents[i].pos.y;
                
                agents[i].vel := get_rand_vel();
                
                agents[i].pos.x := agents[i].pos.x + agents[i].vel.x * scale;
                agents[i].pos.y := agents[i].pos.y + agents[i].vel.y * scale;
                
                DrawLine(agents[i].prev_pos.x, agents[i].prev_pos.y, agents[i].pos.x, agents[i].pos.y, agents[i].color);
                
            end;

        EndDrawing();
    end;

    CloseWindow();
end.

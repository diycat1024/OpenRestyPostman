#!/usr/bin/lua
local co_running    = assert(coroutine.running)
local co_create     = assert(coroutine.create)
local co_yield      = assert(coroutine.yield)
local co_resume     = assert(coroutine.resume)

local co_pools = {}

local function create_co(func)

    local co = table.remove(co_pools)
    if co then

        -- 如果有此协程，那么直接唤醒并进行使用
        -- 协程内部已经将执行函数设置为新的 func
        co_resume(co, func)

    else

        -- 如果没有此协程，那么需要新建一个辅助协程
        co = co_create(function()

            -- 执行入口函数
            func()

            -- 类似于一个主循环，永远不退出本协程
            while true do

                -- 执行完后，重新放入到池，等待下一次唤醒
                table.insert(co_pools, co)

                -- 执行完毕挂起来等待，下次唤醒之后，就是新的入口函数了
                func = co_yield(0)

                -- 先不执行，等待下一个唤醒，主动进行
                co_yield()

                -- 执行，外部调用了 resume
                func()

            end

        end)

    end

    return co

end

local function test_1()

    print("test 1 ----->>. ", co_running())

end

local function test_2()

    print("test 2 ------->>.", co_running())

    co_yield "aaa"

end

local function test_3()

    print("test 3 ------>>. ", co_running())

end

local function test_pool()

    local co_1 = create_co(test_1)
    co_resume(co_1)

    local co_2 = create_co(test_2)
    local co_3 = create_co(test_3)

    co_resume(co_2)
    co_resume(co_3)

end

function main()

    print("enter main function!")

    test_pool()


end

main()


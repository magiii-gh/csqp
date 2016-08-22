-----------------------------------------------------------------------
---这个里面定义消息类型，为了简单不易出错选用字符串作为消息明
-----------------------------------------------------------------------
EventDef = {}

EventDef.SELECTED_HERO                      = "select_hero"                                 -- 战斗列表选择英雄
EventDef.SELECTED_HEROINFO                  = "select_hero_info"                            -- 英雄列表英雄信息
EventDef.UPDATE_HERO_INFO                   = "update_hero_info"                            -- 更新英雄信息
EventDef.SELECTED_HEROINFO_UPSTAR           = "select_heroinfo_upstar"                      -- 需要升星的英雄信息
EventDef.SELECTED_EQUIPINFO                 = "select_eqiup_info"                           -- 获取装备信息
EventDef.TIP_HEROINFO                       = "tip_heroinfo"                                -- 显示英雄Tip信息
EventDef.TIP_ITEMINFO                       = "tip_iteminfo"                                -- 显示物品Tip信息
EventDef.SELECTED_HERO                      = "select_hero"                                 -- 战斗列表选择英雄
EventDef.SELECTED_TASKITEM                  = "select_task_item"                            -- 选择任务项
EventDef.BUTTON_CLECKED_TASKITEM            = "button_clicked_item"                         -- 任务项中按钮按下
EventDef.UPDATE_HERO_INFO                   = "update_hero_info"                            -- 更新英雄信息
EventDef.BUTTON_LUCKYDRAW_ONE_CLICKED       = "button_luckydraw_one_clicked"                -- 祈福一次按钮事件
EventDef.BUTTON_LUCKYDRAW_TEN_CLICKED       = "button_luckydraw_ten_clicked"                -- 祈福十次按钮事件
EventDef.SELECT_CHAPTER_INDEX               = "select_chapter_index"                        -- 选择指定关卡
EventDef.SET_CHAPTER_NAME                   = "set_chapter_name"                            -- 设置关卡名称 
EventDef.CLOSE_MERGE_LAYER                  = "close_merge_layer"                           -- 关闭合成面板
EventDef.SHOW_MERGE_LAYER                  	= "show_merge_layer"                            -- 打开合成面板
EventDef.RETURN_ONEQUIP_LAYER               = "return_onequip_layer"                        -- 回到穿装备界面
EventDef.SELECTED_BAGINFO                   = "select_bag_info"                             -- 获取背包信息
EventDef.SELECTED_SERVERINFO                = "select_server_info"                          -- 获取服务器列表
EventDef.SELECTED_MAILINFO                  = "select_mail_info"                            -- 获取邮件信息
EventDef.PVP_CLICKED_HERO                   = "pvp_clicked_hero"                            -- pvp英雄点击
EventDef.USE_ITEM_HERO                      = "use_item_hero"                               -- 使用物品增加hero经验
EventDef.UPDATE_GOLDS                       = "update_golds"                                -- 更新金币
EventDef.UPDATE_DIAMONDS                    = "update_diamonds"                             -- 更新钻石
EventDef.UPDATE_LEVEL                       = "update_level"                                -- 更新等级
EventDef.UPDATE_POWER                       = "update_power"                                -- 增加体力
EventDef.SHOW_MAIN_CITY_MASK                = "show_main_city_mask"                         -- 显示主场景的背景mask
EventDef.SELECTED_NOTACTIVEHERO             = "selected_notactivehero"                      -- 选择未激活英雄
EventDef.SURE_CALL_HERO                     = "sure_call_hero"                              -- 确认召唤英雄
EventDef.UPDATE_HERO_LIST_LAYER             = "update_hero_list_layer"                      -- 更新英雄列表面板
EventDef.MOVE_HERO_TEAM                     = "move_hero_team"                              -- 移动英雄组  
EventDef.SIGN                               = "sign"                                        -- 签到
EventDef.CREATE_BATTLE_PACKAGE				= "create_battle_package"						-- 创建战斗包
EventDef.UPDATE_BATTLE_RANDOM				= "update_battle_random"						-- 更新战斗色子
EventDef.CHECK_RANGE_TRIGGLE                = "Check_Range_Triggle"                         -- 检查范围触发器
EventDef.CHECK_ROUND_TRIGGLE                = "Check_Round_Triggle"                         -- 检查回合触发器
EventDef.CHECK_IDSTATE_TRIGGLE              = "Check_Idstate_Triggle"                       -- 检查指定ID状态发生变化时触发器
EventDef.CHANGE_TEAM_CELL_STATE             = "change_team_cell_state"                      -- 队伍状态发生改变 

EventDef.VERSION_UPDATE_PROGRESS            = "version_update_progress"                     --版本更新进度
EventDef.VERSION_UPDATE_MESSAGE             = "version_update_message"                      --版本更新消息 
EventDef.GET_CHAT_LIST                      = "get_chat_list"                               --获取聊天列表
EventDef.SET_CARD_DATA                      = "set_card_data"                               --设置卡牌数据
EventDef.UPDATE_SELECTED_STATE              = "update_selected_state"                       --取消选中状态
EventDef.CARD_POINT_MAXED                   = "card_point_maxed"                            --卡牌位已满
EventDef.SET_CARD_DATA_FOR_GUIDE            = "set_card_data_for_guide"                     --设置图鉴已有卡牌数据
EventDef.SET_CARD_HERO_STATE                = "set_card_hero_state"                     	--设置戰鬥場景英雄狀態
 
EventDef.UPDATE_TIP                         = "update_tip"                     	            --更新提示
EventDef.CANCEL_TIP                         = "cancel_tip"                     	            --取消提示
EventDef.RESET_NAME                         = "reset_name"                                  --重新设置玩家名称
EventDef.RESET_HEAD                         = "reset_head"                                  --重新设置玩家头像

EventDef.UPDATE_SWEEP                       = "update_sweep"                                --扫荡功能
EventDef.REMOVE_RELIVE_ANIM 				= "remove_relive_anim"   						--移除复活动画
EventDef.UPDATE_EXP                         = "update_exp"                                  --玩家经验
EventDef.OPEN_CHAT                          = "open_chat"                                   --打开聊天信息面板
EventDef.UPDATE_PLAYER_INFO                 = "update_player_info"                     		--更新玩家信息
local ipairs = ipairs;
local require = require;
local type = type;

local reload = reload;

local M = {};
_G[...] = M;
package.loaded[...] = M;
_ENV = M;


local apps_ = nil;

--�û����ü���app��
--����1��ȫ��ж��Ȼ�����¼��ء�
--����2������ȽϺ�ж�غͼ��ء�
--����3��ֱ�������������¼��ء�

local function unload()
	if type(apps_)~='table' then return end
	for i,v in ipairs(apps_) do
		require(v).on_unload();
	end
end

function load()
	unload();
	local apps_ = reload'cfg.app';
	if type(apps_)~='table' then return end
	for i,v in ipairs(apps_) do
		reload(v).on_load();
	end
end

function init()
	if type(apps_)~='table' then return end
	for i,v in ipairs(apps_) do
		require(v).on_init();
	end
end

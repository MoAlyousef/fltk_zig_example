const c = @cImport({
    @cInclude("cfl_group.h");
});
const widget = @import("widget.zig");

pub const GroupPtr = ?*c.Fl_Group;

pub const Group = struct {
    inner: ?*c.Fl_Group,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [:0]const u8) Group {
        const ptr = c.Fl_Group_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return Group{
            .inner = ptr,
        };
    }

    pub fn raw(self: *Group) ?*c.Fl_Group {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Group) Group {
        return Group{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) Group {
        return Group{
            .inner = @ptrCast(*c.Fl_Group, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) Group {
        return Group{
            .inner = @ptrCast(*c.Fl_Group, ptr),
        };
    }

    pub fn asWidget(self: *const Group) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn handle(self: *Group, cb: fn (ev: i32, data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Group_handle(self.inner, cb, data);
    }

    pub fn draw(self: *Group, cb: fn (data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Group_draw(self.inner, cb, data);
    }

    pub fn begin(self: *Group) void {
        c.Fl_Group_begin(self.inner);
    }

    pub fn end(self: *Group) void {
        c.Fl_Group_end(self.inner);
    }

    pub fn clear(self: *Group) void {
        c.Fl_Group_clear(self.inner);
    }

    pub fn children(self: *const Group) u32 {
        c.Fl_Group_children(self.inner);
    }
    fn child(self: *const Group, idx: u32) !Widget {
        const ptr = c.Fl_Group_child(idx);
        if (ptr == 0) unreachable;
        return Widget{
            .inner = ptr,
        };
    }
};

pub const Pack = struct {
    inner: ?*c.Fl_Pack,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [:0]const u8) Pack {
        const ptr = c.Fl_Pack_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return Pack{
            .inner = ptr,
        };
    }

    pub fn raw(self: *Pack) ?*c.Fl_Pack {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Pack) Pack {
        return Pack{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) Pack {
        return Pack{
            .inner = @ptrCast(*c.Fl_Pack, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) Pack {
        return Pack{
            .inner = @ptrCast(*c.Fl_Pack, ptr),
        };
    }

    pub fn asWidget(self: *const Pack) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn asGroup(self: *const Pack) Group {
        return Group{
            .inner = @ptrCast(?*c.Fl_Group, self.inner),
        };
    }

    pub fn handle(self: *Pack, cb: fn (ev: i32, data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Pack_handle(self.inner, cb, data);
    }

    pub fn draw(self: *Pack, cb: fn (data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Pack_draw(self.inner, cb, data);
    }
};

pub const Tabs = struct {
    inner: ?*c.Fl_Tabs,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [:0]const u8) Tabs {
        const ptr = c.Fl_Tabs_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return Tabs{
            .inner = ptr,
        };
    }

    pub fn raw(self: *Tabs) ?*c.Fl_Tabs {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Tabs) Tabs {
        return Tabs{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) Tabs {
        return Tabs{
            .inner = @ptrCast(*c.Fl_Tabs, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) Tabs {
        return Tabs{
            .inner = @ptrCast(*c.Fl_Tabs, ptr),
        };
    }

    pub fn asWidget(self: *const Tabs) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn asGroup(self: *const Tabs) Group {
        return Group{
            .inner = @ptrCast(?*c.Fl_Group, self.inner),
        };
    }

    pub fn handle(self: *Tabs, cb: fn (ev: i32, data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Tabs_handle(self.inner, cb, data);
    }

    pub fn draw(self: *Tabs, cb: fn (data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Tabs_draw(self.inner, cb, data);
    }

    pub fn find(self: *const Group, widget: *widget.Widget) u32 {
        return c.Fl_Group_find(self.inner, widget.raw());
    }

    pub fn add(self: *Group, widget: *widget.Widget) void {
        return c.Fl_Group_add(self.inner, widget.raw());
    }

    pub fn insert(self: *Group, widget: *widget.Widget, index: u32) void {
        return c.Fl_Group_insert(self.inner, widget.raw(), index);
    }

    pub fn remove(self: *Group, widget: *widget.Widget) void {
        return c.Fl_Group_remove(self.inner, widget.raw());
    }

    pub fn resizable(self: *const Group, widget: *widget.Widget) void {
        return c.Fl_Group_resizable(self.inner, widget.raw());
    }
};

pub const Scroll = struct {
    inner: ?*c.Fl_Scroll,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [:0]const u8) Scroll {
        const ptr = c.Fl_Scroll_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return Scroll{
            .inner = ptr,
        };
    }

    pub fn raw(self: *Scroll) ?*c.Fl_Scroll {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Scroll) Scroll {
        return Scroll{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) Scroll {
        return Scroll{
            .inner = @ptrCast(*c.Fl_Scroll, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) Scroll {
        return Scroll{
            .inner = @ptrCast(*c.Fl_Scroll, ptr),
        };
    }

    pub fn asWidget(self: *const Scroll) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn asGroup(self: *const Scroll) Group {
        return Group{
            .inner = @ptrCast(?*c.Fl_Group, self.inner),
        };
    }

    pub fn handle(self: *Scroll, cb: fn (ev: i32, data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Scroll_handle(self.inner, cb, data);
    }

    pub fn draw(self: *Scroll, cb: fn (data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Scroll_draw(self.inner, cb, data);
    }
};
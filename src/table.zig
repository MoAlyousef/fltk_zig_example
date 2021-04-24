const c = @cImport({
    @cInclude("cfl_table.h");
});
const widget = @import("widget.zig");

pub const Table = struct {
    inner: ?*c.Fl_Table,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [*c]const u8) Table {
        const ptr = c.Fl_Table_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return Table{
            .inner = ptr,
        };
    }

    pub fn raw(self: *Table) ?*c.Fl_Table {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Table) Table {
        return Table{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) Table {
        return Table{
            .inner = @ptrCast(?*c.Fl_Table, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) Table {
        return Table{
            .inner = @ptrCast(?*c.Fl_Table, ptr),
        };
    }

    pub fn toVoidPtr(self: *Table) ?*c_void {
        return @ptrCast(?*c_void, self.inner);
    }

    pub fn asWidget(self: *const Table) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn handle(self: *Table, cb: fn (w: ?*c.Fl_Widget, ev: i32 data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Table_handle(self.inner, cb, data);
    }

    pub fn draw(self: *Table, cb: fn (w: ?*c.Fl_Widget, data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Table_draw(self.inner, cb, data);
    }
};

pub const TableRow = struct {
    inner: ?*c.Fl_Table_Row,
    pub fn new(x: i32, y: i32, w: i32, h: i32, title: [*c]const u8) TableRow {
        const ptr = c.Fl_Table_Row_new(x, y, w, h, title);
        if (ptr == null) unreachable;
        return TableRow{
            .inner = ptr,
        };
    }

    pub fn raw(self: *TableRow) ?*c.Fl_Table_Row {
        return self.inner;
    }

    pub fn fromRaw(ptr: ?*c.Fl_Table_Row) TableRow {
        return TableRow{
            .inner = ptr,
        };
    }

    pub fn fromWidgetPtr(w: widget.WidgetPtr) TableRow {
        return TableRow{
            .inner = @ptrCast(?*c.Fl_Table_Row, w),
        };
    }

    pub fn fromVoidPtr(ptr: ?*c_void) TableRow {
        return TableRow{
            .inner = @ptrCast(?*c.Fl_Table_Row, ptr),
        };
    }

    pub fn toVoidPtr(self: *TableRow) ?*c_void {
        return @ptrCast(?*c_void, self.inner);
    }

    pub fn asWidget(self: *const TableRow) widget.Widget {
        return widget.Widget{
            .inner = @ptrCast(widget.WidgetPtr, self.inner),
        };
    }

    pub fn asTable(self: *const TableRow) Table {
        return Table{
            .inner = @ptrCast(?*c.Fl_Table, self.inner),
        };
    }

    pub fn handle(self: *TableRow, cb: fn (w: ?*c.Fl_Widget, ev: i32 data: ?*c_void) callconv(.C) i32, data: ?*c_void) void {
        c.Fl_Table_Row_handle(self.inner, cb, data);
    }

    pub fn draw(self: *TableRow, cb: fn (w: ?*c.Fl_Widget, data: ?*c_void) callconv(.C) void, data: ?*c_void) void {
        c.Fl_Table_Row_draw(self.inner, cb, data);
    }
};

test "" {
    @import("std").testing.refAllDecls(@This());
}